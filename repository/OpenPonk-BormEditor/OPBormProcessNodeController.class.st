Class {
	#name : #OPBormProcessNodeController,
	#superclass : #OPBormElementController,
	#instVars : [
		'ownerParticipant'
	],
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #adding }
OPBormProcessNodeController >> addAsSourceFor: aController [
	self assert: (self canBeSourceFor: aController).
	aController source: self
]

{ #category : #adding }
OPBormProcessNodeController >> addAsTargetFor: aController [
	self assert: (self canBeTargetFor: aController).
	aController target: self.
	aController
		createModelIn: self model
		andShowInDiagram: self diagramController
]

{ #category : #adding }
OPBormProcessNodeController >> bormModels [
	^ self diagramController editor workbench projectController project models
		select: [ :each | each isKindOf: self diagramController modelClass ]
]

{ #category : #'ui hooks' }
OPBormProcessNodeController >> buildEditorForm: aForm [
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
OPBormProcessNodeController >> canBeSourceFor: aController [
	^ self subclassResponsibility
]

{ #category : #testing }
OPBormProcessNodeController >> canBeTargetFor: aController [
	^ self subclassResponsibility
]

{ #category : #accessing }
OPBormProcessNodeController >> dependentElements [
	^ model transitions
]

{ #category : #accessing }
OPBormProcessNodeController >> ownerParticipant [
	^ ownerParticipant
]

{ #category : #accessing }
OPBormProcessNodeController >> ownerParticipant: aParticipantController [
	ownerParticipant := aParticipantController
]

{ #category : #hooks }
OPBormProcessNodeController >> refreshFigure [
	figure update
]

{ #category : #destruction }
OPBormProcessNodeController >> removeFigure [
	super removeFigure.
	self ownerParticipant removedNodeFigure: figure
]

{ #category : #destruction }
OPBormProcessNodeController >> removeModel [
	self model owner remove: self model
]

{ #category : #removing }
OPBormProcessNodeController >> removeModelElement: aTransition [
	self model removeTransition: aTransition.
	aTransition target removeTransition: aTransition
]

{ #category : #construction }
OPBormProcessNodeController >> showInDiagram: aDiagramController [
	super showInDiagram: aDiagramController.
	self
		ownerParticipant:
			(aDiagramController
				controllerForModel:
					(aDiagramController model participants
						detect: [ :any | any elements includes: model ]))
]

{ #category : #construction }
OPBormProcessNodeController >> showWithDependentInDiagram: aDiagramController [
	super showWithDependentInDiagram: aDiagramController.
	self
		ownerParticipant:
			(aDiagramController
				controllerForModel:
					(aDiagramController model participants
						detect: [ :any | any elements includes: model ]))
]
