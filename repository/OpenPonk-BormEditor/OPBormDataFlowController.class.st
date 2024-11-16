Class {
	#name : 'OPBormDataFlowController',
	#superclass : 'OPBormAssociationEnhancementController',
	#instVars : [
		'labelFigure',
		'iconFigure'
	],
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'forms' }
OPBormDataFlowController >> buildEditorForm: aForm [

	super buildEditorForm: aForm.
	(aForm addDroplist: 'Type')
		items: #( #input #output );
		display: [ :type | type asString ];
		selectItem: self model type;
		whenSelectedItemChangedDo: [ :newValue |
			self model type: newValue.
			self modelChanged ]
]

{ #category : 'testing' }
OPBormDataFlowController >> canVisitTarget: aController [
	^ aController canBeTargetForDataFlow: self
]

{ #category : 'construction' }
OPBormDataFlowController >> diagramElementClass [

	^ BormDataFlowShape
]

{ #category : 'accessing' }
OPBormDataFlowController >> modelClass [
	^ BormDataFlow
]

{ #category : 'destruction' }
OPBormDataFlowController >> removeModel [

	self model owner remove: self model.
	super removeModel
]
