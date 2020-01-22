"
BormBasicLayout provides elementary layouting for BORM ORDiagram.

1. Each participant is:
	1.1. layouted with RTTreeLayout
	1.2. expanded to encompass the layouted tree
2. All participants are layouted with RTHorizontalLine.
"
Class {
	#name : #OPBormBasicLayout,
	#superclass : #Object,
	#instVars : [
		'diagramController'
	],
	#category : #'OpenPonk-BormEditor-Layouting'
}

{ #category : #public }
OPBormBasicLayout >> applyLayout [
	self layoutDiagram: diagramController model
]

{ #category : #'as yet unclassified' }
OPBormBasicLayout >> collectCommunications: participants [
	| communications |
	communications := OrderedCollection new.
	participants do: [ :p | p nodes select: [ :n | n isKindOf: BormActivity ] thenDo: [ :n | communications addAll: n sent asOrderedCollection ] ].
	^ communications
]

{ #category : #accessing }
OPBormBasicLayout >> diagramController: aBormDiagramController [
	diagramController := aBormDiagramController
]

{ #category : #'as yet unclassified' }
OPBormBasicLayout >> layoutCommunications: communications [
	communications
		do:
			[ :c | 
			| figures rect currentMid targetMid vector |
			figures := c dataFlows
				collect: [ :each | (diagramController controllerForModel: each) figure ].
			figures isNotEmpty
				ifTrue:
					[ 
					RTHorizontalLineLayout new
						gapSize: 10;
						on: figures.
					rect := Rectangle merging: (figures collect: [ :each | each encompassingRectangle ]).
					currentMid := rect center.
					targetMid := (diagramController controllerForModel: c) figure encompassingRectangle
						center.
					vector := targetMid - currentMid.
					figures do: [ :flow | flow translateBy: vector - (0 @ flow height) ].

					figures do: [ :flow | flow announce: TRMouseDragEnd new ] ] ]
]

{ #category : #layouting }
OPBormBasicLayout >> layoutDiagram: aDiagram [
	aDiagram participants do: [ :each | self layoutParticipant: each ].
	self layoutParticipants: aDiagram participants.
	self updateView.
	self layoutCommunications: (self collectCommunications: aDiagram participants).
	self updateView
]

{ #category : #'as yet unclassified' }
OPBormBasicLayout >> layoutNode: aNode [
	| figure bounds |
	figure := (diagramController controllerForModel: aNode) figure.
	bounds := figure encompassingRectangle.
	bounds := bounds
		merge:
			((figure isKindOf: BormNodeFigure)
				ifTrue: [ figure text encompassingRectangle ]
				ifFalse: [ (figure attributeAt: #RTLabelledLabel) encompassingRectangle ]).
	RTNest new resizeWithoutRecursion: figure bounds: bounds
]

{ #category : #layouting }
OPBormBasicLayout >> layoutParticipant: aParticipant [
	| ctrl bounds |
	ctrl := diagramController controllerForModel: aParticipant.
	aParticipant nodes do: [ :each | self layoutNode: each ].
	RTDominanceTreeLayout new
		horizontalGap: 30;
		verticalGap: 30;
		on: ctrl nodeFigures.
	bounds := ctrl nodeFigures asGroup encompassingRectangle.
	bounds := bounds expandBy: 40 @ 30.
	RTNest new resizeWithoutRecursion: ctrl figure bounds: bounds
]

{ #category : #layouting }
OPBormBasicLayout >> layoutParticipants: participants [
	| figures |
	figures := participants collect: [ :each | (diagramController controllerForModel: each) figure ].
	RTHorizontalLineLayout new gapSize: 50; on: figures
]

{ #category : #updating }
OPBormBasicLayout >> updateView [
	diagramController view signalUpdate.
	diagramController view canvas camera focusOnCenter
]
