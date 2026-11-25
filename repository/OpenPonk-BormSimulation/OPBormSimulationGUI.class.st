"
Simulation GUI presenter for BORM diagrams. Coordinates modular playback controls, highlighter-based diagram overlays, and the embedded constraint configuration sidebar to pause on newly encountered unmet constraints and synchronize visual state.
"
Class {
	#name : 'OPBormSimulationGUI',
	#superclass : 'OPSimulationGUI',
	#instVars : [
		'blockedElementSimulators'
	],
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'private - hooks' }
OPBormSimulationGUI >> afterStepVisualsUpdated [

	self handleUnmetConstraintsAfterStep
]

{ #category : 'configuration' }
OPBormSimulationGUI >> buildConfigurationPresenter [

	^ (self instantiate: OPBormConstraintMenuGUI on: self diagramSimulator)
		  onConstraintChanged: [ :constraintSimulator | self handleConstraintChanged: constraintSimulator ];
		  yourself
]

{ #category : 'private - hooks' }
OPBormSimulationGUI >> buttonItems [

	^ {
		  self newPlayPauseButton.
		  (self newStepButtonLabeled: 'Step all' help: 'Step all elements once' action: [ self stepAll ]).
		  self newResetButton.
		  (self newConfigureButtonLabeled: 'Constraints' help: 'Toggle constraint conditions sidebar') }
]

{ #category : 'private - updating' }
OPBormSimulationGUI >> handleConstraintChanged: aConstraintSimulator [

	self updateSimulationVisuals.
	self configurationPresenter ifNotNil: [ :activeConfiguration | activeConfiguration refreshFromSimulator ]
]

{ #category : 'private - updating' }
OPBormSimulationGUI >> handleReloaded [

	blockedElementSimulators removeAll.
	super handleReloaded
]

{ #category : 'private - updating' }
OPBormSimulationGUI >> handleSimulatorReset: aResetEvent [

	blockedElementSimulators removeAll.
	super handleSimulatorReset: aResetEvent
]

{ #category : 'private - updating' }
OPBormSimulationGUI >> handleUnmetConstraintsAfterStep [

	| currentlyBlocked newlyBlocked |
	diagramSimulator ifNil: [ ^ self ].
	currentlyBlocked := diagramSimulator blockedByConstraintElements asIdentitySet.
	newlyBlocked := currentlyBlocked difference: blockedElementSimulators.
	blockedElementSimulators := currentlyBlocked.
	newlyBlocked isNotEmpty ifTrue: [
			self showConfiguration.
			self session ifNotNil: [ :activeSession | activeSession pause ].
			^ self ].
	self isConfigurationVisible ifTrue: [
		self configurationPresenter ifNotNil: [ :activeConfiguration | activeConfiguration refreshFromSimulator ] ]
]

{ #category : 'testing' }
OPBormSimulationGUI >> hasConfiguration [

	^ true
]

{ #category : 'private - updating' }
OPBormSimulationGUI >> highlightColorForElement: anElement [

	anElement isSteppable ifTrue: [ ^ Color green ].
	anElement tokenCount > 0 ifFalse: [ ^ nil ].
	(anElement outgoing isEmpty and: [ anElement inputCondition ]) ifTrue: [ ^ Color pink ].
	^ Color lightOrange lighter
]

{ #category : 'private - updating' }
OPBormSimulationGUI >> highlightDataFlowsFor: anElementSimulator [

	anElementSimulator outgoing
		select: [ :eachEdge | eachEdge isKindOf: OPBormCommunicationSimulator ]
		thenDo: [ :eachCommunication |
				eachCommunication model dataFlows ifNotEmpty: [ :dataFlows |
						highlighter highlightFillOfModel: eachCommunication target model color: Color yellow.
						dataFlows do: [ :eachDataFlow | highlighter highlightFillOfModel: eachDataFlow color: Color yellow ] ] ]
]

{ #category : 'initialization' }
OPBormSimulationGUI >> initialize [

	super initialize.
	blockedElementSimulators := IdentitySet new
]

{ #category : 'configuration' }
OPBormSimulationGUI >> showConfiguration [

	super showConfiguration.
	self configurationPresenter ifNotNil: [ :activeConfiguration | activeConfiguration refreshFromSimulator ]
]

{ #category : 'private - hooks' }
OPBormSimulationGUI >> simulatorClass [
	^ OPBormSimulator
]

{ #category : 'actions' }
OPBormSimulationGUI >> stepAll [

	self session ifNil: [ ^ self ].
	(diagramSimulator isNotNil and: [
		 diagramSimulator isSteppable not and: [ diagramSimulator blockedByConstraintElements isNotEmpty ] ]) ifTrue: [
		^ self showConfiguration ].
	self session step
]

{ #category : 'private - hooks' }
OPBormSimulationGUI >> updateSimulationVisuals [

	(diagramSimulator isNil or: [ highlighter isNil ]) ifTrue: [ ^ self ].
	highlighter replaceHighlightsDuring: [
			| steppableElements |
			steppableElements := OrderedCollection new.
			diagramSimulator simulableElements do: [ :eachElement |
					eachElement isSteppable ifTrue: [ steppableElements add: eachElement ].
					(self highlightColorForElement: eachElement) ifNotNil: [ :highlightColor |
						highlighter highlightFillOfModel: eachElement model color: highlightColor ] ].
			steppableElements do: [ :eachElement | self highlightDataFlowsFor: eachElement ] ]
]
