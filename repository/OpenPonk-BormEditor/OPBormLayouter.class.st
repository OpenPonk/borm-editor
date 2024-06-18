"
BormBasicLayout provides elementary layouting for BORM ORDiagram.

1. Each participant is:
	1.1. layouted with RTTreeLayout
	1.2. expanded to encompass the layouted tree
2. All participants are layouted with RTHorizontalLine.
"
Class {
	#name : 'OPBormLayouter',
	#superclass : 'OPLayouter',
	#category : 'OpenPonk-BormEditor-Adapters',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Adapters'
}

{ #category : 'as yet unclassified' }
OPBormLayouter class >> supportedLayoutCommands [
	^ {OPBormLayoutCommand.
	OPDominanceTreeLayoutCommand.
	OPGridLayoutCommand.
	OPSugiyamaLayoutCommand.
	OPTreeLayoutCommand}
]

{ #category : 'accessing' }
OPBormLayouter >> allEdges [
	^ #()
]

{ #category : 'accessing' }
OPBormLayouter >> allNodes [
	^ diagramController controllers
		select: [ :ctrl | ctrl isKindOf: OPBormParticipantController ]
		thenCollect: #roassalShape
]

{ #category : 'public' }
OPBormLayouter >> applyLayout: aTwoArgBlock [
	diagramController model participants
		do: [ :each | self layoutParticipant: each ].
	super applyLayout: aTwoArgBlock
]

{ #category : 'as yet unclassified' }
OPBormLayouter >> collectCommunications: participants [
	| communications |
	communications := OrderedCollection new.
	participants do: [ :p | p nodes select: [ :n | n isKindOf: BormActivity ] thenDo: [ :n | communications addAll: n sent asOrderedCollection ] ].
	^ communications
]

{ #category : 'public' }
OPBormLayouter >> defaultLayout [
	self layoutDiagram: diagramController model
]

{ #category : 'as yet unclassified' }
OPBormLayouter >> layoutCommunication: aCommunication [

	| figures rect currentMid targetMid vector |
	figures := OrderedCollection new.
	aCommunication dataFlows do: [ :each | 
		diagramController
			controllerForModel: each
			ifFound: [ :ctrl | figures add: ctrl roassalShape ] ].

	figures ifEmpty: [ ^ self ].

	RSHorizontalLineLayout new
		gapSize: 10;
		on: figures.
	rect := Rectangle merging:
		        (figures collect: [ :each | each encompassingRectangle ]).
	currentMid := rect center.
	targetMid := (diagramController controllerForModel: aCommunication)
		             roassalShape encompassingRectangle center.
	vector := targetMid - currentMid.
	figures do: [ :flow | 
		flow translateBy: vector - (0 @ flow height).
		(flow propertyAt: OPRSAnchorConstraint) saveShapePosition ]
]

{ #category : 'as yet unclassified' }
OPBormLayouter >> layoutCommunications: communications [

	communications do: [ :c | self layoutCommunication: c ]
]

{ #category : 'layouting' }
OPBormLayouter >> layoutDiagram: aDiagram [

	| shownParticipants |
	shownParticipants := aDiagram participants select: [ :each | 
		                     diagramController hasControllerForModel: each ].
	shownParticipants do: [ :each | self layoutParticipant: each ].
	self layoutParticipants: shownParticipants.
	self updateCanvas.
	self layoutCommunications:
		(self collectCommunications: shownParticipants).
	self updateCanvas
]

{ #category : 'as yet unclassified' }
OPBormLayouter >> layoutNode: aNode [

	| figure bounds |
	figure := (diagramController
		           controllerForModel: aNode
		           ifNone: [ ^ self ]) roassalShape.
	bounds := figure encompassingRectangle.
	bounds := bounds merge:
		          (figure propertyAt: #RSLabeled) encompassingRectangle.
	figure extent: bounds extent
]

{ #category : 'layouting' }
OPBormLayouter >> layoutNodesInParticipant: aParticipant [

	| ctrl nodeShapes |
	ctrl := diagramController controllerForModel: aParticipant.
	aParticipant nodes do: [ :each | self layoutNode: each ].
	nodeShapes := ctrl nodeRoassalShapes.
	RSDominanceTreeLayout new
		horizontalGap: 30;
		verticalGap: 30;
		on: nodeShapes
]

{ #category : 'layouting' }
OPBormLayouter >> layoutParticipant: aParticipant [
	self
		layoutNodesInParticipant: aParticipant;
		layoutSizeOfParticipant: aParticipant
]

{ #category : 'layouting' }
OPBormLayouter >> layoutParticipants: participants [

	| controllers participantShapes |
	controllers := participants collect: [ :each |
		               diagramController controllerForModel: each ].
	controllers do: [ :eachParticipantCtrl |
		eachParticipantCtrl roassalShape
			when: RSPositionChangedEvent
			do: [ :event |
				eachParticipantCtrl nodeRoassalShapes do: [ :each |
					each translateBy: event newPosition - event oldPosition ] ]
			for: self ].
	participantShapes := controllers collect: #roassalShape.
	RSHorizontalLineLayout new
		gapSize: 50;
		on: participantShapes.
	participantShapes do: [ :each | each announcer unsubscribe: self ]
]

{ #category : 'layouting' }
OPBormLayouter >> layoutSizeOfParticipant: aParticipant [

	| ctrl bounds roassalShape innerBounds |
	ctrl := diagramController controllerForModel: aParticipant.
	roassalShape := ctrl roassalShape.
	innerBounds := (RSGroup withAll: ctrl nodeRoassalShapes)
		               encompassingRectangle.
	bounds := innerBounds expandBy: 40 @ 30.
	ctrl roassalShape
		extent: bounds extent;
		translateTo: bounds center
]

{ #category : 'layouting' }
OPBormLayouter >> layoutSizesOfParticipants [
	diagramController model participants
		do: [ :each | self layoutSizeOfParticipant: each ]
]
