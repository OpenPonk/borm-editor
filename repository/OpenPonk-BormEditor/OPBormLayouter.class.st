"
I provide elementary automated layouting for BORM Object Relation diagrams. 

My layout strategy works in two steps:
1. Each participant is layouted internally (its process nodes are arranged using a tree layout) and its boundaries are expanded to encompass the layouted tree.
2. All participants are then arranged side-by-side using a horizontal line layout.
"
Class {
	#name : 'OPBormLayouter',
	#superclass : 'OPNodesAndEdgesLayouter',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
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

{ #category : 'userinterface' }
OPBormLayouter >> applyLayout: aTwoArgBlock [
	diagramController model participants
		do: [ :each | self layoutParticipant: each ].
	super applyLayout: aTwoArgBlock
]

{ #category : 'private - collecting' }
OPBormLayouter >> collectCommunications: participants [

	| communications |
	communications := OrderedCollection new.
	participants do: [ :p |
			p nodes
				select: [ :n | n isKindOf: BormActivity ]
				thenDo: [ :n | communications addAll: n sent ] ].
	^ communications
]

{ #category : 'layouts' }
OPBormLayouter >> defaultLayout [
	self layoutDiagram: diagramController model
]

{ #category : 'processing' }
OPBormLayouter >> layoutCommunication: aCommunication [

	| roassalShapes rect currentMid targetMid vector |
	roassalShapes := OrderedCollection new.
	aCommunication dataFlows do: [ :each |
		diagramController
			controllerForModel: each
			ifFound: [ :ctrl | roassalShapes add: ctrl roassalShape ] ].

	roassalShapes ifEmpty: [ ^ self ].

	RSHorizontalLineLayout new
		gapSize: 10;
		on: roassalShapes.
	rect := Rectangle merging:
		        (roassalShapes collect: [ :each |
			         each encompassingRectangle ]).
	currentMid := rect center.
	targetMid := (diagramController controllerForModel: aCommunication)
		             roassalShape encompassingRectangle center.
	vector := targetMid - currentMid.
	roassalShapes do: [ :flow |
		flow translateBy: vector - (0 @ flow height).
		(flow propertyAt: OPRSAnchorConstraint) saveShapePosition ]
]

{ #category : 'processing' }
OPBormLayouter >> layoutCommunications: communications [

	communications do: [ :c | self layoutCommunication: c ]
]

{ #category : 'processing' }
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

{ #category : 'processing' }
OPBormLayouter >> layoutNode: aNode [

	| roassalShape bounds |
	roassalShape := (diagramController
		                 controllerForModel: aNode
		                 ifNone: [ ^ self ]) roassalShape.
	bounds := roassalShape encompassingRectangle.
	bounds := bounds merge:
		          (roassalShape propertyAt: #RSLabeled)
			          encompassingRectangle.
	roassalShape extent: bounds extent
]

{ #category : 'processing' }
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

{ #category : 'processing' }
OPBormLayouter >> layoutParticipant: aParticipant [
	self
		layoutNodesInParticipant: aParticipant;
		layoutSizeOfParticipant: aParticipant
]

{ #category : 'processing' }
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

{ #category : 'processing' }
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

{ #category : 'processing' }
OPBormLayouter >> layoutSizesOfParticipants [
	diagramController model participants
		do: [ :each | self layoutSizeOfParticipant: each ]
]
