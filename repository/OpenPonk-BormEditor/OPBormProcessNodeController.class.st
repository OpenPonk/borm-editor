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

{ #category : 'forms' }
OPBormProcessNodeController >> buildEditorForm: aForm [

	(aForm addText: 'Name')
		text: self model name;
		whenTextChangedDo: [ :newValue |
			self model name: newValue asString.
			self modelChanged ].
	self diagramController editor ifNil: [ ^ self ].
	(aForm addDroplist: 'Submodel')
		items: { nil } , self bormModels;
		display: [ :m | m ifNil: '' ifNotNil: #name ];
		selectItem: self model submodel;
		whenSelectedItemChangedDo: [ :newValue |
			self model submodel: newValue.
			self modelChanged ].
	(aForm addDroplist: 'Input Transition Condition')
		items: (BormNodeSimulationCondition allSubclasses collect: #new);
		display: [ :type | type nameAsInput ];
		selectItem: self model inputTransitionSimulationCondition;
		whenSelectedItemChangedDo: [ :newValue |
			self model inputTransitionSimulationCondition: newValue ].
	(aForm addDroplist: 'Input Communication Condition')
		items: (BormNodeSimulationCondition allSubclasses collect: #new);
		display: [ :type | type nameAsInput ];
		selectItem: self model inputCommunicationSimulationCondition;
		whenSelectedItemChangedDo: [ :newValue |
			self model inputCommunicationSimulationCondition: newValue ].
	(aForm addDroplist: 'Output Condition')
		items: (BormNodeSimulationCondition allSubclasses collect: #new);
		display: [ :type | type nameAsOutput ];
		selectItem: self model outputSimulationCondition;
		whenSelectedItemChangedDo: [ :newValue |
			self model outputSimulationCondition: newValue ]
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
	^ self model transitions
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

	self model owner remove: self model.
	super removeModel
]

{ #category : 'diagram elements' }
OPBormProcessNodeController >> unhookDiagramElement [

	super unhookDiagramElement.

	(self diagramElement ifNotExists: [ ^ self ]) plusIconAction: [  ]
]
