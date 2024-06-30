Class {
	#name : 'OPBormProcessNodeController',
	#superclass : 'OPBormElementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'adding' }
OPBormProcessNodeController >> bormModels [
	^ self diagramController editor workbench projectController project models
		select: [ :each | each isKindOf: self diagramController modelClass ]
]

{ #category : 'ui hooks' }
OPBormProcessNodeController >> buildEditorForm: aForm [

	(aForm addText: 'Name')
		text: self model name;
		whenTextChangedDo: [ :newValue |
			self model name: newValue asString.
			self diagramElement modelChanged ].
	self diagramController editor ifNil: [ ^ self ].
	(aForm addDroplist: 'Submodel')
		items: { nil } , self bormModels;
		display: [ :m | m ifNil: '' ifNotNil: #name ];
		selectItem: self model submodel;
		whenSelectedItemChangedDo: [ :newValue |
			self model submodel: newValue.
			self diagramElement modelChanged ]
]

{ #category : 'testing' }
OPBormProcessNodeController >> canBeSourceFor: aController [
	^ self subclassResponsibility
]

{ #category : 'testing' }
OPBormProcessNodeController >> canBeTargetFor: aController [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
OPBormProcessNodeController >> dependentElements [
	^ model transitions
]

{ #category : 'construction' }
OPBormProcessNodeController >> dependingOnElements [

	^ super dependingOnElements
	  , (Set with: (self model participant ifNil: [
				    self error: 'There is no participant of ' , self model asString ]))
]

{ #category : 'construction' }
OPBormProcessNodeController >> hookDiagramElement [

	super hookDiagramElement.
	
	self diagramElement plusIconAction: [ 
		self diagramController editor workbench openEditorOn:
			self model submodel ]
]

{ #category : 'destruction' }
OPBormProcessNodeController >> removeModel [
	self model owner remove: self model
]
