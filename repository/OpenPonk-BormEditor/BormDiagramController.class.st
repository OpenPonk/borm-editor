Class {
	#name : #BormDiagramController,
	#superclass : #OPDiagramController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #accessing }
BormDiagramController class >> modelClass [
	^ BormORModel
]

{ #category : #testing }
BormDiagramController >> addAsTargetFor: aController [
	super addAsTargetFor: aController.
	aController figure translateBy: (aController figure width / 2.5) @ (aController figure height / 2.2)
]

{ #category : #rebuilding }
BormDiagramController >> allOwnedElementsInModel [
	^ model elements
]

{ #category : #rebuilding }
BormDiagramController >> allRelationshipsInModel [
	^ self model elements
		flatCollect: [ :eachParticipant | 
			eachParticipant nodes
				flatCollect: [ :eachNode | 
					eachNode outgoing
						,
							((eachNode respondsTo: #sent)
								ifTrue: [ eachNode sent ]
								ifFalse: [ #() ]) ] ]
]

{ #category : #userinterface }
BormDiagramController >> applyDefaultLayout [
	BormBasicLayout new
		diagramController: self;
		applyLayout
]

{ #category : #testing }
BormDiagramController >> canBeTargetFor: aController [
	^ aController isMemberOf: BormParticipantController
]

{ #category : #testing }
BormDiagramController >> hasRedo [
	self flag: 'Disabled due to RTBitmap canvas issues'.
	^ false
]

{ #category : #testing }
BormDiagramController >> hasUndo [
	self flag: 'Disabled due to RTBitmap canvas issues'.
	^ false
]

{ #category : #initialization }
BormDiagramController >> initializePalette: aPalette [
	(aPalette newCreationTool: [ BormParticipantController new ])
		label: 'Participant';
		icon: BormEditorIcons current participant16Icon.
	aPalette newSeparator.
	(aPalette newCreationTool: [ BormStateController new ])
		label: 'State';
		icon: BormEditorIcons current state16Icon.
	(aPalette newCreationTool: [ BormActivityController new ])
		label: 'Activity';
		icon: BormEditorIcons current activity16Icon.
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ BormTransitionController new ])
		label: 'Transition';
		icon: BormEditorIcons current transition16Icon.
	(aPalette newConnectionCreationTool: [ BormCommunicationController new ])
		label: 'Communication';
		icon: BormEditorIcons current communication16Icon.
	aPalette newSeparator.
	(aPalette newCreationTool: [ BormDataFlowController new ])
		label: 'Data Flow';
		icon: BormEditorIcons current dataFlow16Icon.
	(aPalette newCreationTool: [ BormConstraintController new ])
		label: 'Constraint';
		icon: BormEditorIcons current constraint16Icon
]

{ #category : #initialization }
BormDiagramController >> initializePaletteWithShortcuts: aPalette [
	(aPalette newCreationTool: [ BormParticipantController new ])
		label: 'Participant';
		icon: BormEditorIcons current participant16Icon;
		shortcut: $q asShortcut.
	aPalette newSeparator.
	(aPalette newCreationTool: [ BormStateController new ])
		label: 'State';
		icon: BormEditorIcons current state16Icon;
		shortcut: $s asShortcut.
	(aPalette newCreationTool: [ BormActivityController new ])
		label: 'Activity';
		icon: BormEditorIcons current activity16Icon;
		shortcut: $a asShortcut.
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ BormTransitionController new ])
		label: 'Transition';
		icon: BormEditorIcons current transition16Icon;
		shortcut: $t asShortcut.
	(aPalette newConnectionCreationTool: [ BormCommunicationController new ])
		label: 'Communication';
		icon: BormEditorIcons current communication16Icon;
		shortcut: $c asShortcut.
	aPalette newSeparator.
	(aPalette newCreationTool: [ BormDataFlowController new ])
		label: 'Data Flow';
		icon: BormEditorIcons current dataFlow16Icon;
		shortcut: $f asShortcut.
	(aPalette newCreationTool: [ BormConstraintController new ])
		label: 'Constraint';
		icon: BormEditorIcons current constraint16Icon;
		shortcut: $r asShortcut
]

{ #category : #accessing }
BormDiagramController >> modelToControllerMapping [
	^ Dictionary new
		at: BormCommunication put: BormCommunicationController;
		at: BormDataFlow put: BormDataFlowController;
		at: BormParticipant put: BormParticipantController;
		at: BormActivity put: BormActivityController;
		at: BormState put: BormStateController;
		at: BormTransition put: BormTransitionController;
		yourself
]

{ #category : #userinterface }
BormDiagramController >> rebuild [
	super rebuild.
	self applyDefaultLayout
]

{ #category : #'as yet unclassified' }
BormDiagramController >> registerModelEvents: aModel [
	super registerModelEvents: aModel.
	aModel announcer
		when: OPModelContentReplaced
		do: [ self rebuild.
			self applyDefaultLayout.
			self view canvas focusOnCenterScaled ]
]

{ #category : #userinterface }
BormDiagramController >> updateView [
	self controllers do: [ :each | each refreshFigure ].
	self view edges
		do: [ :each | 
			each pushFront.
			each update ].
	self view signalUpdate
]
