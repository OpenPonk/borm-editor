Class {
	#name : #OPBormDiagramController,
	#superclass : #OPDiagramController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #accessing }
OPBormDiagramController class >> modelClass [
	^ BormORModel
]

{ #category : #testing }
OPBormDiagramController >> addAsTargetFor: aController [
	super addAsTargetFor: aController.
	aController figure translateBy: (aController figure width / 2.5) @ (aController figure height / 2.2)
]

{ #category : #rebuilding }
OPBormDiagramController >> allRelationshipsInModel [
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

{ #category : #'as yet unclassified' }
OPBormDiagramController >> allShowableElements [
	"Should return all elements that could be directly hidden on diagram"

	^ (model allEntities flatCollect: [ :each | each representations ])
		, self diagram commonElements
]

{ #category : #testing }
OPBormDiagramController >> canBeTargetFor: aController [
	^ (super canBeTargetFor: aController)
		or: [ aController isMemberOf: OPBormParticipantController ]
]

{ #category : #'as yet unclassified' }
OPBormDiagramController >> commonModelClassPrefix [
	^ 'Borm'
]

{ #category : #accessing }
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

{ #category : #rebuilding }
OPBormDiagramController >> elementsToShowInside [
	^ model participants
]

{ #category : #testing }
OPBormDiagramController >> hasRedo [
	self flag: 'Disabled due to RTBitmap canvas issues'.
	^ false
]

{ #category : #testing }
OPBormDiagramController >> hasUndo [
	self flag: 'Disabled due to RTBitmap canvas issues'.
	^ false
]

{ #category : #initialization }
OPBormDiagramController >> initializePalette: aPalette [
	(aPalette newCreationTool: [ OPBormParticipantController new ])
		label: 'Participant';
		icon: OPBormEditorIcons current participant16Icon.
	aPalette newSeparator.
	(aPalette newCreationTool: [ OPBormStateController new ])
		label: 'State';
		icon: OPBormEditorIcons current state16Icon.
	(aPalette newCreationTool: [ OPBormActivityController new ])
		label: 'Activity';
		icon: OPBormEditorIcons current activity16Icon.
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ OPBormTransitionController new ])
		label: 'Transition';
		icon: OPBormEditorIcons current transition16Icon.
	(aPalette newConnectionCreationTool: [ OPBormCommunicationController new ])
		label: 'Communication';
		icon: OPBormEditorIcons current communication16Icon.
	aPalette newSeparator.
	(aPalette newCreationTool: [ OPBormDataFlowController new ])
		label: 'Data Flow';
		icon: OPBormEditorIcons current dataFlow16Icon.
	(aPalette newCreationTool: [ OPBormConstraintController new ])
		label: 'Constraint';
		icon: OPBormEditorIcons current constraint16Icon
]

{ #category : #initialization }
OPBormDiagramController >> initializePaletteWithShortcuts: aPalette [
	(aPalette newCreationTool: [ OPBormParticipantController new ])
		label: 'Participant';
		icon: OPBormEditorIcons current participant16Icon;
		shortcut: $q asShortcut.
	aPalette newSeparator.
	(aPalette newCreationTool: [ OPBormStateController new ])
		label: 'State';
		icon: OPBormEditorIcons current state16Icon;
		shortcut: $s asShortcut.
	(aPalette newCreationTool: [ OPBormActivityController new ])
		label: 'Activity';
		icon: OPBormEditorIcons current activity16Icon;
		shortcut: $a asShortcut.
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ OPBormTransitionController new ])
		label: 'Transition';
		icon: OPBormEditorIcons current transition16Icon;
		shortcut: $t asShortcut.
	(aPalette newConnectionCreationTool: [ OPBormCommunicationController new ])
		label: 'Communication';
		icon: OPBormEditorIcons current communication16Icon;
		shortcut: $c asShortcut.
	aPalette newSeparator.
	(aPalette newCreationTool: [ OPBormDataFlowController new ])
		label: 'Data Flow';
		icon: OPBormEditorIcons current dataFlow16Icon;
		shortcut: $f asShortcut.
	(aPalette newCreationTool: [ OPBormConstraintController new ])
		label: 'Constraint';
		icon: OPBormEditorIcons current constraint16Icon;
		shortcut: $r asShortcut
]

{ #category : #accessing }
OPBormDiagramController >> layout: aLayout [
	super layout: aLayout.
	(aLayout noneSatisfy: [ :any | any hasExtent ])
		ifTrue: [ self layouter layoutSizesOfParticipants ].
	self updateView
]

{ #category : #'as yet unclassified' }
OPBormDiagramController >> registerModelEvents: aModel [
	super registerModelEvents: aModel.
	aModel announcer
		when: OPModelContentReplaced
		do: [ self rebuild.
			self applyDefaultLayout.
			self view canvas focusOnCenterScaled ]
]

{ #category : #userinterface }
OPBormDiagramController >> updateView [

	self controllers do: [ :each | each refreshFigure ].
	self view edges do: [ :each | 
		each pushFront.
		each update ].
	self view signalUpdate
]
