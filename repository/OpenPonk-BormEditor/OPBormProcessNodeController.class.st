Class {
	#name : #OPBormProcessNodeController,
	#superclass : #OPBormElementController,
	#instVars : [
		'ownerParticipant'
	],
	#category : #'OpenPonk-BormEditor-Controllers'
}

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
		whenTextIsAccepted: [ :newValue | 
			self model name: newValue asString.
			self refreshFigure ].
	(aForm addDroplist: 'Submodel')
		items: {nil} , self bormModels;
		displayBlock: [ :m | m ifNil: '' ifNotNil: #name ];
		setSelectedItem: self model submodel;
		whenSelectedItemChanged: [ :newValue | 
			self model submodel: newValue.
			self refreshFigure ]
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

{ #category : #construction }
OPBormProcessNodeController >> figureClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
OPBormProcessNodeController >> layout: anElementLayout [
	super layout: anElementLayout.
	anElementLayout hasExtent
		ifTrue: [ self figure shape extent: anElementLayout extent ]
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
	figure update.
	^ self figure
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

{ #category : #construction }
OPBormProcessNodeController >> renderFigureIn: aView [
	self diagramController addingFigureFor: self.
	figure := self figureClass on: self model.
	figure renderIn: aView.
	figure plusIcon
		when: TRMouseLeftClick
		do: [ self diagramController editor workbench
				openEditorOn: self model submodel ].
	(self diagramController
		showWithoutDependentInDiagramModel: self model owner)
		addedNodeFigure: figure.
	^ self diagramController addedFigureFor: self
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
OPBormProcessNodeController >> showWithoutDependentInDiagram: aDiagramController [
	super showWithoutDependentInDiagram: aDiagramController.
	self
		ownerParticipant:
			(aDiagramController
				controllerForModel:
					(aDiagramController model participants
						detect: [ :any | any elements includes: model ]))
]
