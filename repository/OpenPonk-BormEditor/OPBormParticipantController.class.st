Class {
	#name : #OPBormParticipantController,
	#superclass : #OPBormElementController,
	#instVars : [
		'elements',
		'iconElement',
		'labelConstraint'
	],
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #accessing }
OPBormParticipantController >> allOwnedElementsInModel [
	^ model nodes
]

{ #category : #hooks }
OPBormParticipantController >> buildEditorForm: aForm [
	super buildEditorForm: aForm.

	(aForm addDroplist: 'Type')
		items: #(#Person #System #Organization);
		iconHolder: [ :type | self typeIconFor: type ];
		displayBlock: [ :type | type asString ];
		setSelectedItem: self model type;
		whenSelectedItemChanged: [ :newValue | self model type: newValue ]
]

{ #category : #testing }
OPBormParticipantController >> canBeTargetFor: aController [
	^ aController isKindOf: OPBormProcessNodeController
]

{ #category : #hooks }
OPBormParticipantController >> createContainerFigure [
	^ (RTRoundedBox new
		width: 200;
		height: 300;
		color: (Color fromHexString: 'bce2fe');
		borderRadius: 2;
		borderColor: Color black) elementOn: ''
]

{ #category : #accessing }
OPBormParticipantController >> modelClass [
	^ BormParticipant
]

{ #category : #accessing }
OPBormParticipantController >> nodeFigures [
	^ elements
]

{ #category : #hooks }
OPBormParticipantController >> refreshFigure [
	(figure attributeAt: #RTLabelledLabel) text: self model name.
	labelConstraint move.
	figure trachelShape pushBack.
	iconElement trachelShape form: self typeIconForModel.
	self diagramController view signalUpdate
]

{ #category : #destruction }
OPBormParticipantController >> removeModel [
	self diagramController model remove: self model
]

{ #category : #accessing }
OPBormParticipantController >> removedNodeFigure: aFigure [
	elements remove: aFigure
]

{ #category : #hooks }
OPBormParticipantController >> renderFigureIn: aView [
	| labeled |
	figure := self createContainerFigure.
	figure
		@ RTGhostDraggable;
		@ RTResizable.
	(labeled := RTLabeled new)
		view: aView;
		top;
		color: Color black.
	figure @ labeled.
	labelConstraint := (RTConstraint on: labeled lbl background: figure)
		topLeft;
		padding: 5;
		stick.
	figure renderIn: aView.
	iconElement := (RTBitmap new form: self typeIconForModel) element.
	iconElement renderIn: aView.
	(RTConstraint on: iconElement background: figure)
		topRight;
		padding: 5;
		stick.
	figure addCallback: (TRRemoveCallback with: iconElement).
	elements := RTGroup new.
	elements @ RTDraggable.
	figure trachelShape
		addCallback:
			(TRTranslationCallback
				block: [ :shape :step | elements do: [ :e | e translateBy: step ] ]).
	self saveStateOnDragEndFor: figure.
	self diagramController figureAdded: figure.
	^ figure
]

{ #category : #'canvas actions' }
OPBormParticipantController >> showDenyFeedbackFor: aController [
	^ nil
]

{ #category : #construction }
OPBormParticipantController >> showInDiagram: aDiagramController [
	super showInDiagram: aDiagramController.
	elements
		addAll:
			(self allOwnedElementsInModel
				collect: [ :each | 
					(aDiagramController controllerForModel: each)
						ownerParticipant: self;
						figure ])
]

{ #category : #hooks }
OPBormParticipantController >> typeIconFor: aType [
	aType = BormParticipantType Person
		ifTrue: [ ^ OPBormEditorIcons current personIcon ].
	aType = BormParticipantType System
		ifTrue: [ ^ OPBormEditorIcons current systemIcon ].
	aType = BormParticipantType Organization
		ifTrue: [ ^ OPBormEditorIcons current organizationIcon ]
]

{ #category : #hooks }
OPBormParticipantController >> typeIconForModel [
	^ self typeIconFor: self model type
]
