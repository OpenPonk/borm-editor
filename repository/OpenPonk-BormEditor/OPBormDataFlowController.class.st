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
		whenSelectedItemChangedDo: [ :newValue | 
			self model type: newValue.
			self refreshFigure ]
]

{ #category : #testing }
OPBormDataFlowController >> canVisitTarget: aController [
	^ aController canBeTargetForDataFlow: self
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

{ #category : #construction }
OPBormDataFlowController >> diagramElementClass [

	^ BormDataFlowShape
]

{ #category : #accessing }
OPBormDataFlowController >> modelClass [
	^ BormDataFlow
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
