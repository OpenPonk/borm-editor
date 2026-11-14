"
I am the primary diagram controller for the BORM editor. I manage the modeling palette, canvas interactions, and targeting rules for creating BORM elements.
"
Class {
	#name : 'OPBormDiagramController',
	#superclass : 'OPDiagramController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPBormDiagramController class >> viewModelClass [

	^ OPBormORViewModel
]

{ #category : 'user interface' }
OPBormDiagramController >> addAsTargetFor: aController [
	self addAsTargetFor: aController onPosition: nil
]

{ #category : 'user interface' }
OPBormDiagramController >> addAsTargetFor: aController onPosition: aPoint [
	super addAsTargetFor: aController onPosition: aPoint.
	aController diagramElement translateBy:
		(aController diagramElement width / 2.5) @ (aController diagramElement height / 2.2)
]

{ #category : 'connecting' }
OPBormDiagramController >> canBeTargetFor: aController [
	^ (super canBeTargetFor: aController)
		or: [ aController isMemberOf: OPBormParticipantController ]
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

{ #category : 'ui interaction' }
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

{ #category : 'userinterface' }
OPBormDiagramController >> updateCanvas [

	self controllers do: [ :each | each modelChanged ].
	self canvas edges do: [ :each |
		each pushFront.
		each update ].
	self canvas signalUpdate
]
