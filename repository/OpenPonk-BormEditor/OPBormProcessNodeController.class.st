Class {
	#name : 'OPBormProcessNodeController',
	#superclass : 'OPBormElementController',
	#instVars : [
		'ownerParticipant'
	],
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'adding' }
OPBormProcessNodeController >> addAsTargetFor: aController [
	self assert: (self canBeTargetFor: aController).
	aController target: self.
	aController
		createModelIn: self model
		andShowInDiagram: self diagramController
]

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
OPBormProcessNodeController >> hookDiagramElement [

	super hookDiagramElement.
	
	self diagramElement plusIconAction: [ 
		self diagramController editor workbench openEditorOn:
			self model submodel ]
]

{ #category : 'accessing' }
OPBormProcessNodeController >> ownerParticipant [
	^ ownerParticipant
]

{ #category : 'accessing' }
OPBormProcessNodeController >> ownerParticipant: aParticipantController [
	ownerParticipant := aParticipantController
]

{ #category : 'destruction' }
OPBormProcessNodeController >> removeModel [
	self model owner remove: self model
]

{ #category : 'construction' }
OPBormProcessNodeController >> setOwnerParticipant [

	self ownerParticipant: (self diagramController controllerForModel:
			 (self diagramController model participants detect: [ :any | 
				  any elements includes: model ]))
]

{ #category : 'construction' }
OPBormProcessNodeController >> showInDiagram: aDiagramController [

	super showInDiagram: aDiagramController.
	self setOwnerParticipant
]

{ #category : 'construction' }
OPBormProcessNodeController >> showWithoutDependentInDiagram: aDiagramController [

	super showWithoutDependentInDiagram: aDiagramController.
	self setOwnerParticipant
]
