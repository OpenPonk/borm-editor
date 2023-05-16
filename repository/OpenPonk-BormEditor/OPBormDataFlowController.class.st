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
			self diagramElement modelChanged ]
]

{ #category : #testing }
OPBormDataFlowController >> canVisitTarget: aController [
	^ aController canBeTargetForDataFlow: self
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

{ #category : #destruction }
OPBormDataFlowController >> removeModel [
	self model owner remove: self model
]
