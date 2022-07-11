Class {
	#name : #OPBormDataFlowController,
	#superclass : #OPBormAssociationEnhancementController,
	#instVars : [
		'labelFigure',
		'iconFigure'
	],
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #'ui hooks' }
OPBormDataFlowController >> buildEditorForm: aForm [

	super buildEditorForm: aForm.
	(aForm addDroplist: 'Type')
		items: #( #input #output );
		display: [ :type | type asString ];
		selectItem: self model type;
		whenSelectedDo: [ :newValue | 
			self model type: newValue.
			self refreshFigure ]
]

{ #category : #testing }
OPBormDataFlowController >> canVisitTarget: aController [
	^ aController canBeTargetForDataFlow: self
]

{ #category : #private }
OPBormDataFlowController >> constraintOnEdge: anElement [

	| cb edge errorBlock |
	super constraintOnEdge: anElement.
	edge := (self diagramController showWithoutDependentInDiagramModel:
		         model owner) figure.
	cb := TRTranslationCallback block: [ self refreshIcon ].
	edge from addCallback: cb.
	edge to addCallback: cb.
	errorBlock := [ 
	              self traceCr:
		              'OPBormDataFlowController>>#constraintOnEdge: - callback does not exist' ].
	anElement addCallback: (TRRemoveCallback block: [ 
			 edge from trachelShape removeCallback: cb ifAbsent: errorBlock.
			 edge to trachelShape removeCallback: cb ifAbsent: errorBlock ])
]

{ #category : #private }
OPBormDataFlowController >> createContainerShape [
	^ RTRoundedBox new
		width: 40;
		height: 35;
		color: Color transparent;
		borderColor: Color gray;
		borderWidth: 0.5
]

{ #category : #construction }
OPBormDataFlowController >> createModelIn: aParentModel [

	self model: self modelClass new.
	aParentModel add: model.
	^ model
]

{ #category : #'canvas actions' }
OPBormDataFlowController >> hideSelectionFeedback [
	figure shape
		borderColor: Color gray;
		borderWidth: 0.5.
	figure updateShape.
	super hideSelectionFeedback
]

{ #category : #accessing }
OPBormDataFlowController >> modelClass [
	^ BormDataFlow
]

{ #category : #hooks }
OPBormDataFlowController >> refreshFigure [

	labelFigure trachelShape text: self model name.
	figure width: (labelFigure width max: 40).
	self refreshIcon.
	^ super refreshFigure
]

{ #category : #'as yet unclassified' }
OPBormDataFlowController >> refreshIcon [

	| edge right |
	edge := (self diagramController showWithoutDependentInDiagramModel:
		         model owner) figure.
	right := edge from position x < edge to position x.
	self model isOutput ifTrue: [ right := right not ].
	iconFigure trachelShape form: (right
			 ifTrue: [ OPBormEditorIcons dataFlowRightIcon ]
			 ifFalse: [ OPBormEditorIcons dataFlowLeftIcon ])
]

{ #category : #destruction }
OPBormDataFlowController >> removeModel [
	self model owner remove: self model
]

{ #category : #private }
OPBormDataFlowController >> renderFigureIn: aView [

	self diagramController addingFigureFor: self.
	figure := self createContainerShape element.
	figure @ RTDraggable.
	labelFigure := RTLabel new
		               height: 10;
		               color: Color black;
		               elementOn: self model.
	(RTConstraint on: labelFigure background: figure)
		top;
		stick.
	iconFigure := (RTBitmap new form:
		               OPBormEditorIcons dataFlowLeftIcon) element.
	(RTConstraint on: iconFigure background: figure trachelShape)
		bottom;
		padding: 5;
		stick.
	figure addCallback:
		(TRRemoveCallback with: iconFigure with: labelFigure).
	aView
		add: figure;
		add: iconFigure;
		add: labelFigure.
	self constraintOnEdge: figure.
	self saveStateOnDragEndFor: figure.
	^ self diagramController addedFigureFor: self
]

{ #category : #'canvas actions' }
OPBormDataFlowController >> showSelectionFeedback [
	figure shape
		borderColor: Color black;
		borderWidth: 1.
	super showSelectionFeedback.
	figure updateShape
]
