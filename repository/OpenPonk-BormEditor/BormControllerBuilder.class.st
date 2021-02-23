Class {
	#name : #BormControllerBuilder,
	#superclass : #Object,
	#instVars : [
		'diagramController',
		'diagram',
		'view'
	],
	#category : #'OpenPonk-BormEditor-Utility'
}

{ #category : #testing }
BormControllerBuilder class >> isDeprecated [
	^ true
]

{ #category : #'private - building' }
BormControllerBuilder >> addDataFlows: dataFlows [
	dataFlows do: [ :each | (self controllerFor: each owner) addAsTargetFor: (self newControllerFor: each) ]
]

{ #category : #'private - building' }
BormControllerBuilder >> addEdge: anEdge [
	| sourceCtrl targetCtrl edgeCtrl |
	sourceCtrl := self controllerFor: anEdge source.
	targetCtrl := self controllerFor: anEdge target.
	edgeCtrl := self newControllerFor: anEdge.
	sourceCtrl addAsSourceFor: edgeCtrl.
	targetCtrl addAsTargetFor: edgeCtrl
]

{ #category : #'private - building' }
BormControllerBuilder >> addEdges: edges [
	edges do: [ :edge | self addEdge: edge ]
]

{ #category : #'private - building' }
BormControllerBuilder >> addNodes: nodes [
	nodes do: [ :node | (self controllerFor: node owner) addAsTargetFor: (self newControllerFor: node) ]
]

{ #category : #'private - building' }
BormControllerBuilder >> addParticipants: participants [
	participants do: [ :p | diagramController addAsTargetFor: (self newControllerFor: p) ]
]

{ #category : #public }
BormControllerBuilder >> build [
	diagramController
		ifNil: [ diagramController := self newDiagramControllerFor: diagram ].
	diagramController view: view.
	self addParticipants: diagram participants.
	self addNodes: (self collectNodes: diagram participants).
	self addEdges: (self collectTransitions: diagram participants).
	self addEdges: (self collectCommunications: diagram participants).
	self addDataFlows: (self collectDataFlows: diagram participants).
	^ diagramController
]

{ #category : #'private - collecting' }
BormControllerBuilder >> collectCommunications: participants [
	^ ((self selectActivities: (self collectNodes: participants)) collect: [ :activity | activity sent ]) flattened
]

{ #category : #'private - collecting' }
BormControllerBuilder >> collectDataFlows: participants [
	^ ((self collectCommunications: participants) collect: [ :comm | comm dataFlows ]) flattened
]

{ #category : #'private - collecting' }
BormControllerBuilder >> collectNodes: participants [
	^ (participants collect: [ :each | each nodes ]) flattened
]

{ #category : #'private - collecting' }
BormControllerBuilder >> collectTransitions: participants [
	^ ((self collectNodes: participants) collect: [ :node | node outgoing ]) flattened
]

{ #category : #'private - factories' }
BormControllerBuilder >> controllerFor: anObject [
	^ diagramController controllerForModel: anObject
]

{ #category : #accessing }
BormControllerBuilder >> diagram: aBormDiagram [
	diagram := aBormDiagram
]

{ #category : #accessing }
BormControllerBuilder >> diagramController: aBormDiagramController [
	diagramController := aBormDiagramController
]

{ #category : #'private - factories' }
BormControllerBuilder >> newControllerFor: anObject [
	^ diagramController newControllerFor: anObject
]

{ #category : #'private - factories' }
BormControllerBuilder >> newDiagramControllerFor: aDiagram [
	^ OPBormDiagramController new
		model: aDiagram;
		yourself
]

{ #category : #'private - collecting' }
BormControllerBuilder >> selectActivities: nodes [
	^ nodes select: [ :node | node isKindOf: BormActivity ]
]

{ #category : #accessing }
BormControllerBuilder >> view: aView [
	view := aView
]
