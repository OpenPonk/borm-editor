Class {
	#name : 'OPBormDiagramController',
	#superclass : 'OPDiagramController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'testing' }
OPBormDiagramController >> addAsTargetFor: aController [

	super addAsTargetFor: aController.
	aController diagramElement translateBy:
		aController diagramElement width / 2.5
		@ (aController diagramElement height / 2.2)
]

{ #category : 'enumerating' }
OPBormDiagramController >> allModelElementsWithPossibleController [

	^ self model allEntities flatCollectAsSet: #representations
]

{ #category : 'testing' }
OPBormDiagramController >> canBeTargetFor: aController [
	^ (super canBeTargetFor: aController)
		or: [ aController isMemberOf: OPBormParticipantController ]
]

{ #category : 'accessing' }
OPBormDiagramController >> commonModelClassPrefix [
	^ 'Borm'
]

{ #category : 'accessing' }
OPBormDiagramController >> controllerFactory [
	^ super controllerFactory
		register: OPBormCommunicationController forModel: BormCommunication;
		register: OPBormDataFlowController forModel: BormDataFlow;
		register: OPBormParticipantController forModel: BormParticipant;
		register: OPBormActivityController forModel: BormActivity;
		register: OPBormStateController forModel: BormState;
		register: OPBormTransitionController forModel: BormTransition;
		register: OPBormConstraintController forModel: BormConstraint
]

{ #category : 'rebuilding' }
OPBormDiagramController >> elementsToShowInside [

	^ self model participants
]

{ #category : 'testing' }
OPBormDiagramController >> hasRedo [
	self flag: 'Disabled due to RTBitmap canvas issues'.
	^ false
]

{ #category : 'testing' }
OPBormDiagramController >> hasUndo [
	self flag: 'Disabled due to RTBitmap canvas issues'.
	^ false
]

{ #category : 'initialization' }
OPBormDiagramController >> initializePalette: aPalette [
	(aPalette newCreationTool: [ OPBormParticipantController new ])
		label: 'Participant';
		icon: OPBormEditorIcons participant16Icon.
	aPalette newSeparator.
	(aPalette newCreationTool: [ OPBormStateController new ])
		label: 'State';
		icon: OPBormEditorIcons state16Icon.
	(aPalette newCreationTool: [ OPBormActivityController new ])
		label: 'Activity';
		icon: OPBormEditorIcons activity16Icon.
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ OPBormTransitionController new ])
		label: 'Transition';
		icon: OPBormEditorIcons transition16Icon.
	(aPalette newConnectionCreationTool: [ OPBormCommunicationController new ])
		label: 'Communication';
		icon: OPBormEditorIcons communication16Icon.
	aPalette newSeparator.
	(aPalette newCreationTool: [ OPBormDataFlowController new ])
		label: 'Data Flow';
		icon: OPBormEditorIcons dataFlow16Icon.
	(aPalette newCreationTool: [ OPBormConstraintController new ])
		label: 'Constraint';
		icon: OPBormEditorIcons constraint16Icon
]

{ #category : 'initialization' }
OPBormDiagramController >> initializePaletteWithShortcuts: aPalette [
	(aPalette newCreationTool: [ OPBormParticipantController new ])
		label: 'Participant';
		icon: OPBormEditorIcons participant16Icon;
		shortcut: $q asShortcut.
	aPalette newSeparator.
	(aPalette newCreationTool: [ OPBormStateController new ])
		label: 'State';
		icon: OPBormEditorIcons state16Icon;
		shortcut: $s asShortcut.
	(aPalette newCreationTool: [ OPBormActivityController new ])
		label: 'Activity';
		icon: OPBormEditorIcons activity16Icon;
		shortcut: $a asShortcut.
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ OPBormTransitionController new ])
		label: 'Transition';
		icon: OPBormEditorIcons transition16Icon;
		shortcut: $t asShortcut.
	(aPalette newConnectionCreationTool: [ OPBormCommunicationController new ])
		label: 'Communication';
		icon: OPBormEditorIcons communication16Icon;
		shortcut: $c asShortcut.
	aPalette newSeparator.
	(aPalette newCreationTool: [ OPBormDataFlowController new ])
		label: 'Data Flow';
		icon: OPBormEditorIcons dataFlow16Icon;
		shortcut: $f asShortcut.
	(aPalette newCreationTool: [ OPBormConstraintController new ])
		label: 'Constraint';
		icon: OPBormEditorIcons constraint16Icon;
		shortcut: $r asShortcut
]

{ #category : 'userinterface' }
OPBormDiagramController >> updateCanvas [

	self controllers do: [ :each | each modelChanged ].
	self canvas edges do: [ :each |
		each pushFront.
		each update ].
	self canvas signalUpdate
]
