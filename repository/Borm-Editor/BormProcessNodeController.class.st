Class {
	#name : #BormProcessNodeController,
	#superclass : #BormElementController,
	#instVars : [
		'ownerParticipant'
	],
	#category : 'Borm-Editor-Controllers'
}

{ #category : #adding }
BormProcessNodeController >> addAsSourceFor: aController [
	self assert: (self canBeSourceFor: aController).
	aController source: self
]

{ #category : #adding }
BormProcessNodeController >> addAsTargetFor: aController [
	self assert: (self canBeTargetFor: aController).
	aController target: self.
	aController
		createModelIn: self model
		andShowInDiagram: self diagramController
]

{ #category : #accessing }
BormProcessNodeController >> allOwnedElementsInModel [
	^ model transitions
]

{ #category : #adding }
BormProcessNodeController >> bormModels [
	^ self diagramController editor workbench projectController project models
		select: [ :each | each isKindOf: self diagramController modelClass ]
]

{ #category : #'ui hooks' }
BormProcessNodeController >> buildEditorForm: aForm [
	(aForm addText: 'Name')
		text: self model name;
		whenTextIsAccepted: [ :newValue | self model name: newValue asString ].
	(aForm addDroplist: 'Submodel')
		items: {nil} , self bormModels;
		displayBlock: [ :m | m ifNil: '' ifNotNil: #name ];
		setSelectedItem: self model submodel;
		whenSelectedItemChanged: [ :newValue | self model submodel: newValue ]
]

{ #category : #testing }
BormProcessNodeController >> canBeSourceFor: aController [
	^ self subclassResponsibility
]

{ #category : #testing }
BormProcessNodeController >> canBeTargetFor: aController [
	^ self subclassResponsibility
]

{ #category : #accessing }
BormProcessNodeController >> ownerParticipant [
	^ ownerParticipant
]

{ #category : #accessing }
BormProcessNodeController >> ownerParticipant: aParticipantController [
	ownerParticipant := aParticipantController
]

{ #category : #hooks }
BormProcessNodeController >> refreshFigure [
	figure update
]

{ #category : #destruction }
BormProcessNodeController >> removeFigure [
	super removeFigure.
	self ownerParticipant removedNodeFigure: figure
]

{ #category : #destruction }
BormProcessNodeController >> removeModel [
	self model owner remove: self model
]

{ #category : #removing }
BormProcessNodeController >> removeModelElement: aTransition [
	self model removeTransition: aTransition.
	aTransition target removeTransition: aTransition
]
