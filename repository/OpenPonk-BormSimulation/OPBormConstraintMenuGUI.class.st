"
Embedded right-sidebar configuration presenter for BORM simulation constraints. Displays all diagram constraints grouped by source node in deterministic order with readable labels, synchronizes checkbox values with OPBormConstraintSimulator instances, and renders a clean empty state when no constraints exist.
"
Class {
	#name : 'OPBormConstraintMenuGUI',
	#superclass : 'OPSimulationConfigurationGUI',
	#instVars : [
		'descriptionLabel',
		'constraintGroups',
		'constraintEntries',
		'onConstraintChangedBlock',
		'isRefreshing'
	],
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'private - formatting' }
OPBormConstraintMenuGUI >> baseHeaderTextForDescriptor: aDescriptor [

	| sourceName participantName |
	sourceName := aDescriptor at: #sourceName.
	participantName := aDescriptor at: #participantName.
	participantName isEmpty ifTrue: [ ^ sourceName ].
	^ String streamContents: [ :stream |
			  stream nextPutAll: sourceName.
			  stream nextPutAll: ' ('.
			  stream nextPutAll: participantName.
			  stream nextPut: $) ]
]

{ #category : 'layout' }
OPBormConstraintMenuGUI >> buildConfigurationLayout [

	| rootLayout |
	rootLayout := SpBoxLayout newTopToBottom
		              borderWidth: 8;
		              spacing: 8;
		              add: descriptionLabel expand: false;
		              yourself.
	constraintGroups do: [ :eachGroup |
			| groupLayout |
			groupLayout := SpBoxLayout newTopToBottom
				               spacing: 2;
				               add: (eachGroup at: #headerLabel) expand: false;
				               yourself.
			(eachGroup at: #entries) do: [ :eachEntry | groupLayout add: (eachEntry at: #checkbox) expand: false ].
			rootLayout add: groupLayout expand: false ].
	^ rootLayout
]

{ #category : 'private' }
OPBormConstraintMenuGUI >> buildEntryForDescriptor: aDescriptor [

	| constraintSimulator checkbox |
	constraintSimulator := aDescriptor at: #constraintSimulator.
	checkbox := self newCheckBox
		            label: (self checkboxLabelForDescriptor: aDescriptor);
		            help: (self checkboxHelpForDescriptor: aDescriptor);
		            state: constraintSimulator value;
		            yourself.
	checkbox whenChangedDo: [ :newState |
			isRefreshing ifFalse: [
					constraintSimulator value: newState.
					onConstraintChangedBlock ifNotNil: [ :aBlock | aBlock cull: constraintSimulator ] ] ].
	^ Dictionary newFrom: {
			  (#constraintSimulator -> constraintSimulator).
			  (#checkbox -> checkbox) }
]

{ #category : 'private' }
OPBormConstraintMenuGUI >> buildGroupForDescriptor: aDescriptor [

	| baseHeaderText headerLabel |
	baseHeaderText := self baseHeaderTextForDescriptor: aDescriptor.
	headerLabel := self newLabel
		               label: baseHeaderText;
		               yourself.
	^ Dictionary newFrom: {
			  (#sourceSimulator -> (aDescriptor at: #sourceSimulator)).
			  (#baseHeaderText -> baseHeaderText).
			  (#headerLabel -> headerLabel).
			  (#entries -> OrderedCollection new) }
]

{ #category : 'private - formatting' }
OPBormConstraintMenuGUI >> checkboxHelpForDescriptor: aDescriptor [

	^ String streamContents: [ :stream |
			  stream nextPutAll: 'Check to mark constraint "'.
			  stream nextPutAll: (aDescriptor at: #constraintName).
			  stream nextPutAll: '" from "'.
			  stream nextPutAll: (aDescriptor at: #sourceName).
			  stream nextPutAll: '" to "'.
			  stream nextPutAll: (aDescriptor at: #targetName).
			  stream nextPutAll: '" as satisfied' ]
]

{ #category : 'private - formatting' }
OPBormConstraintMenuGUI >> checkboxLabelForDescriptor: aDescriptor [

	^ String streamContents: [ :stream |
			  stream nextPutAll: (aDescriptor at: #constraintName).
			  stream nextPutAll: ' -> '.
			  stream nextPutAll: (aDescriptor at: #targetName) ]
]

{ #category : 'private' }
OPBormConstraintMenuGUI >> collectedConstraintDescriptors [

	| descriptors seenConstraints |
	diagramSimulator ifNil: [ ^ #(  ) ].
	descriptors := OrderedCollection new.
	seenConstraints := IdentitySet new.
	diagramSimulator simulableElements do: [ :eachSource |
			eachSource outgoing do: [ :eachEdge |
					eachEdge model constraint ifNotNil: [ :eachConstraint |
							| constraintSimulator |
							constraintSimulator := diagramSimulator simulatorOf: eachConstraint.
							(seenConstraints includes: constraintSimulator) ifFalse: [
									seenConstraints add: constraintSimulator.
									descriptors add: (self descriptorForSource: eachSource edge: eachEdge constraint: constraintSimulator) ] ] ] ].
	^ descriptors sorted: [ :first :second | self descriptor: first precedes: second ]
]

{ #category : 'accessing' }
OPBormConstraintMenuGUI >> constraintCheckboxes [

	^ constraintEntries collect: [ :eachEntry | eachEntry at: #checkbox ]
]

{ #category : 'accessing' }
OPBormConstraintMenuGUI >> descriptionLabel [

	^ descriptionLabel
]

{ #category : 'private' }
OPBormConstraintMenuGUI >> descriptor: firstDescriptor precedes: secondDescriptor [

	| firstKey secondKey |
	firstKey := firstDescriptor at: #sortKey.
	secondKey := secondDescriptor at: #sortKey.
	1 to: firstKey size do: [ :index |
			| left right |
			left := firstKey at: index.
			right := secondKey at: index.
			left = right ifFalse: [ ^ left < right ] ].
	^ false
]

{ #category : 'private' }
OPBormConstraintMenuGUI >> descriptorForSource: aSourceSimulator edge: anEdgeSimulator constraint: aConstraintSimulator [

	| sourceName participantName constraintName targetName |
	sourceName := self displayNameForNode: aSourceSimulator model.
	participantName := self participantNameForNode: aSourceSimulator model.
	constraintName := self displayNameForConstraint: aConstraintSimulator model.
	targetName := self displayNameForTarget: anEdgeSimulator target relativeTo: aSourceSimulator.
	^ Dictionary newFrom: {
			  (#sourceSimulator -> aSourceSimulator).
			  (#edgeSimulator -> anEdgeSimulator).
			  (#constraintSimulator -> aConstraintSimulator).
			  (#sourceName -> sourceName).
			  (#participantName -> participantName).
			  (#constraintName -> constraintName).
			  (#targetName -> targetName).
			  (#sortKey -> {
				   sourceName asLowercase.
				   sourceName.
				   participantName asLowercase.
				   participantName.
				   aSourceSimulator model uuid asString.
				   constraintName asLowercase.
				   constraintName.
				   targetName asLowercase.
				   targetName.
				   aConstraintSimulator model uuid asString }) }
]

{ #category : 'private - formatting' }
OPBormConstraintMenuGUI >> displayNameForConstraint: aConstraint [

	^ (self trimmedNameOrNil: aConstraint name) ifNil: [ '(unnamed constraint)' ]
]

{ #category : 'private - formatting' }
OPBormConstraintMenuGUI >> displayNameForNode: aNode [

	(self trimmedNameOrNil: aNode name) ifNotNil: [ :trimmedName | ^ trimmedName ].
	aNode isState ifTrue: [ ^ '(unnamed state)' ].
	aNode isActivity ifTrue: [ ^ '(unnamed activity)' ].
	^ '(unnamed node)'
]

{ #category : 'private - formatting' }
OPBormConstraintMenuGUI >> displayNameForTarget: aTargetSimulator relativeTo: aSourceSimulator [

	| targetName sourceParticipant targetParticipant |
	targetName := self displayNameForNode: aTargetSimulator model.
	sourceParticipant := self participantNameForNode: aSourceSimulator model.
	targetParticipant := self participantNameForNode: aTargetSimulator model.
	(sourceParticipant isNotEmpty and: [ targetParticipant isNotEmpty and: [ targetParticipant ~= sourceParticipant ] ]) ifFalse: [
		^ targetName ].
	^ String streamContents: [ :stream |
			  stream nextPutAll: targetName.
			  stream nextPutAll: ' ('.
			  stream nextPutAll: targetParticipant.
			  stream nextPut: $) ]
]

{ #category : 'accessing' }
OPBormConstraintMenuGUI >> emptyStateMessage [

	^ 'No constraints in this diagram.'
]

{ #category : 'accessing' }
OPBormConstraintMenuGUI >> groupHeaderLabels [

	^ constraintGroups collect: [ :eachGroup | eachGroup at: #headerLabel ]
]

{ #category : 'testing' }
OPBormConstraintMenuGUI >> hasConfigurableItems [

	^ constraintEntries isNotEmpty
]

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> initializePresenters [

	super initializePresenters.
	constraintGroups := OrderedCollection new.
	constraintEntries := OrderedCollection new.
	isRefreshing := false.
	descriptionLabel := self newLabel
		                    label: 'Checked conditions are satisfied during simulation.';
		                    yourself.
	self rebuildConstraintPresenters
]

{ #category : 'private' }
OPBormConstraintMenuGUI >> matchesCurrentSimulator [

	| currentDescriptors |
	diagramSimulator ifNil: [ ^ constraintEntries isEmpty ].
	currentDescriptors := self collectedConstraintDescriptors.
	constraintEntries size = currentDescriptors size ifFalse: [ ^ false ].
	^ (1 to: constraintEntries size) allSatisfy: [ :index |
		  ((constraintEntries at: index) at: #constraintSimulator) == ((currentDescriptors at: index) at: #constraintSimulator) ]
]

{ #category : 'accessing' }
OPBormConstraintMenuGUI >> onConstraintChanged: aBlock [

	onConstraintChangedBlock := aBlock
]

{ #category : 'private - formatting' }
OPBormConstraintMenuGUI >> participantNameForNode: aNode [

	| nodeParticipant |
	nodeParticipant := aNode participant.
	(nodeParticipant isKindOf: BormParticipant) ifFalse: [ ^ '' ].
	^ (self trimmedNameOrNil: nodeParticipant name) ifNil: [ '' ]
]

{ #category : 'private' }
OPBormConstraintMenuGUI >> rebuildConstraintPresenters [

	| groupsBySource |
	constraintGroups := OrderedCollection new.
	constraintEntries := OrderedCollection new.
	groupsBySource := IdentityDictionary new.
	self collectedConstraintDescriptors do: [ :eachDescriptor |
			| sourceSimulator group entry |
			sourceSimulator := eachDescriptor at: #sourceSimulator.
			group := groupsBySource at: sourceSimulator ifAbsentPut: [
					         | newGroup |
					         newGroup := self buildGroupForDescriptor: eachDescriptor.
					         constraintGroups add: newGroup.
					         newGroup ].
			entry := self buildEntryForDescriptor: eachDescriptor.
			(group at: #entries) add: entry.
			constraintEntries add: entry ].
	self synchronizePresentersFromSimulator
]

{ #category : 'updating' }
OPBormConstraintMenuGUI >> refreshFromSimulator [

	self matchesCurrentSimulator ifFalse: [
			self rebuildConstraintPresenters.
			self isBuilt ifFalse: [ layout := nil ].
			^ self ].
	self synchronizePresentersFromSimulator
]

{ #category : 'private' }
OPBormConstraintMenuGUI >> synchronizePresentersFromSimulator [

	isRefreshing := true.
	[
		constraintEntries do: [ :eachEntry | (eachEntry at: #checkbox) state: (eachEntry at: #constraintSimulator) value ].
		constraintGroups do: [ :eachGroup | self updateHeaderLabelForGroup: eachGroup ] ] ensure: [ isRefreshing := false ]
]

{ #category : 'private - formatting' }
OPBormConstraintMenuGUI >> trimmedNameOrNil: aString [

	| trimmed |
	aString ifNil: [ ^ nil ].
	trimmed := aString asString trimBoth.
	^ trimmed isEmpty
		  ifTrue: [ nil ]
		  ifFalse: [ trimmed ]
]

{ #category : 'private' }
OPBormConstraintMenuGUI >> updateHeaderLabelForGroup: aGroup [

	| headerText |
	headerText := aGroup at: #baseHeaderText.
	(aGroup at: #sourceSimulator) isBlockedByConstraints ifTrue: [ headerText := headerText , ' [waiting]' ].
	(aGroup at: #headerLabel) label: headerText
]
