Class {
	#name : #BormParticipantController,
	#superclass : #BormElementController,
	#instVars : [
		'elements',
		'iconElement',
		'labelConstraint'
	],
	#category : 'Borm-Editor-Controllers'
}

{ #category : #adding }
BormParticipantController >> addAsTargetFor: aNodeController [
	| newNode |
	self assert: (self canBeTargetFor: aNodeController).
	aNodeController diagramController: self diagramController.
	newNode := aNodeController createModel.
	self model add: newNode.
	aNodeController model: newNode.
	self diagramController controllers add: aNodeController.
	aNodeController attach.
	elements add: aNodeController figure
]

{ #category : #accessing }
BormParticipantController >> allOwnedElementsInModel [
	^ model nodes
]

{ #category : #hooks }
BormParticipantController >> buildEditorForm: aForm [
	super buildEditorForm: aForm.

	(aForm addDroplist: 'Type')
		items: #(#Person #System #Organization);
		iconHolder: [ :type | self typeIconFor: type ];
		displayBlock: [ :type | type asString ];
		setSelectedItem: self model type;
		whenSelectedItemChanged: [ :newValue | self model type: newValue ]
]

{ #category : #testing }
BormParticipantController >> canBeTargetFor: aController [
	^ aController isKindOf: BormProcessNodeController
]

{ #category : #hooks }
BormParticipantController >> createContainerFigure [
	^ (RTRoundedBox new
		width: 200;
		height: 300;
		color: (Color fromHexString: 'bce2fe');
		borderRadius: 2;
		borderColor: Color black) elementOn: ''
]

{ #category : #accessing }
BormParticipantController >> createModelIn: aParentModel [
	self model: self modelClass new.
	aParentModel add: model.
	^ model
]

{ #category : #accessing }
BormParticipantController >> modelClass [
	^ BormParticipant
]

{ #category : #accessing }
BormParticipantController >> nodeFigures [
	^ elements
]

{ #category : #hooks }
BormParticipantController >> refreshFigure [
	(figure attributeAt: #RTLabelledLabel) text: self model name.
	labelConstraint move.
	figure trachelShape pushBack.
	iconElement trachelShape form: self typeIconForModel.
	self diagramController view signalUpdate
]

{ #category : #destruction }
BormParticipantController >> removeModel [
	self diagramController model remove: self model
]

{ #category : #accessing }
BormParticipantController >> removedNodeFigure: aFigure [
	elements remove: aFigure
]

{ #category : #hooks }
BormParticipantController >> renderFigureIn: aView [
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
BormParticipantController >> showDenyFeedbackFor: aController [
	^ nil
]

{ #category : #construction }
BormParticipantController >> showInDiagram: aDiagramController [
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
BormParticipantController >> typeIconFor: aType [
	aType = BormParticipantType Person
		ifTrue: [ ^ BormEditorIcons current personIcon ].
	aType = BormParticipantType System
		ifTrue: [ ^ BormEditorIcons current systemIcon ].
	aType = BormParticipantType Organization
		ifTrue: [ ^ BormEditorIcons current organizationIcon ]
]

{ #category : #hooks }
BormParticipantController >> typeIconForModel [
	^ self typeIconFor: self model type
]
