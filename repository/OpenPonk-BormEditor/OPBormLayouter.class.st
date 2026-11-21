"
I provide elementary automated layouting for BORM Object Relation diagrams. 

My layout strategy works in two steps:
1. Each participant is layouted internally (its process nodes are arranged using a tree layout) and its boundaries are expanded to encompass the layouted tree.
2. All participants are then arranged side-by-side using a horizontal line layout.
"
Class {
	#name : 'OPBormLayouter',
	#superclass : 'OPHierarchicalNodesAndEdgesLayouter',
	#instVars : [
		'activeSnapshot'
	],
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
	"Answers all relationship shapes rendered in the diagram."

	| relationshipControllers |
	relationshipControllers := diagramController controllers select: [ :eachController |
		eachController isKindOf: OPDirectionalRelationshipController ].
	^ (relationshipControllers collect: #roassalShape thenSelect: #isNotNil) asGroup
]

{ #category : 'accessing' }
OPBormLayouter >> allNodes [
	"Answers all rendered node shapes in diagram."

	^ self allRenderedNodeShapes
]

{ #category : 'userinterface' }
OPBormLayouter >> applyLayout: aTwoArgBlock [

	| allTargetNodes snapshot activeContainers topLevelBoxes topLevelEdges |
	activeSnapshot ifNotNil: [
			topLevelBoxes := self topLevelNodeShapes.
			topLevelEdges := self participantEdgesFor: topLevelBoxes.
			aTwoArgBlock value: topLevelBoxes value: topLevelEdges.
			^ self finalizeLayoutWithSnapshot: activeSnapshot ].

	allTargetNodes := self allRenderedNodeShapes.
	snapshot := OPDiagramGeometrySnapshot onNodes: allTargetNodes.
	activeSnapshot := snapshot.
	activeContainers := self containerElementsBottomUp.
	[
		self layoutContainersHierarchically: activeContainers.
		topLevelBoxes := self topLevelNodeShapes.
		topLevelEdges := self participantEdgesFor: topLevelBoxes.
		aTwoArgBlock value: topLevelBoxes value: topLevelEdges.
		self finalizeLayoutWithSnapshot: snapshot ] ensure: [
			self unsubscribeContainers: activeContainers.
			activeSnapshot := nil ]
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

{ #category : 'private' }
OPBormLayouter >> communicationRanksFor: aCollectionOfParticipantControllers [
	"Answers a dictionary mapping participant controllers to horizontal rank indices based on communication flows."

	| ranks unrankedRank maxRank |
	unrankedRank := Float infinity.
	ranks := Dictionary new.
	aCollectionOfParticipantControllers do: [ :eachController |
		| hasInitialNode |
		hasInitialNode := eachController model nodes anySatisfy: [ :eachNode |
			(eachNode respondsTo: #isInitial) and: [ eachNode isInitial ] ].
		ranks at: eachController put: (hasInitialNode ifTrue: [ 0 ] ifFalse: [ unrankedRank ]) ].

	(ranks values allSatisfy: [ :eachRank | eachRank = unrankedRank ]) ifTrue: [
		| rootController |
		rootController := aCollectionOfParticipantControllers detectMax: [ :eachController |
			(eachController model nodes select: #isActivity) sumNumbers: [ :eachActivity |
				eachActivity sent size ] ].
		rootController ifNotNil: [ ranks at: rootController put: 0 ] ].

	aCollectionOfParticipantControllers size timesRepeat: [
		aCollectionOfParticipantControllers do: [ :sourceController |
			| sourceRank |
			sourceRank := ranks at: sourceController.
			sourceRank < unrankedRank ifTrue: [
				(sourceController model nodes select: #isActivity) do: [ :eachActivity |
					eachActivity sent do: [ :eachCommunication |
						| targetModel targetController |
						targetModel := eachCommunication receiver participant.
						targetController := aCollectionOfParticipantControllers
							detect: [ :eachCandidate | eachCandidate model == targetModel ]
							ifNone: [ nil ].
						(targetController isNotNil and: [ targetController ~~ sourceController ]) ifTrue: [
							| currentTargetRank |
							currentTargetRank := ranks at: targetController.
							currentTargetRank > (sourceRank + 1) ifTrue: [
								ranks at: targetController put: sourceRank + 1 ] ] ] ] ] ] ].

	maxRank := (ranks values reject: [ :eachRank | eachRank = unrankedRank ])
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :valuesCollection | valuesCollection max ].

	aCollectionOfParticipantControllers do: [ :eachController |
		(ranks at: eachController) = unrankedRank ifTrue: [
			maxRank := maxRank + 1.
			ranks at: eachController put: maxRank ] ].

	^ ranks
]

{ #category : 'layouts' }
OPBormLayouter >> defaultLayout [
	"Executes default hierarchical layout for BORM diagram."

	self applyLayout: [ :boxes :edges |
			RSHorizontalLineLayout new
				gapSize: 75;
				on: (self sortedTopLevelBoxes: boxes) ]
]

{ #category : 'private' }
OPBormLayouter >> finalizeLayoutWithSnapshot: aSnapshot [

	| shownParticipants commands |
	self unsubscribeContainers: self containerElementsBottomUp.
	shownParticipants := diagramController model participants select: [ :eachParticipant |
		                     diagramController hasControllerForModel: eachParticipant ].
	self layoutCommunications: (self collectCommunications: shownParticipants).
	commands := aSnapshot deltaCommands.
	self executeLayoutCommands: commands.
	self updateCanvas
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

{ #category : 'layouts' }
OPBormLayouter >> layoutInnerContentOf: aContainerElement shapes: directShapes edges: directEdges [
	"Arranges inner states and activities of a participant using Sugiyama layout, normalizing coordinates to origin."
	directShapes ifNotEmpty: [
		RSSugiyamaLayout new
			verticalGap: 36;
			horizontalGap: 36;
			on: directShapes edges: directEdges.
		directShapes translateTo: 0 @ 0 ]
]

{ #category : 'private' }
OPBormLayouter >> participantEdgesFor: aCollectionOfShapes [
	"Answers top-level edges including derived participant-to-participant communication edges."

	| shapeByParticipantModel seenPairs edges |
	edges := OrderedCollection withAll: (self innerEdgesFor: aCollectionOfShapes).
	shapeByParticipantModel := IdentityDictionary new.
	diagramController controllers do: [ :eachController |
			((eachController isKindOf: OPBormParticipantController) and: [ aCollectionOfShapes includes: eachController roassalShape ])
				ifTrue: [ shapeByParticipantModel at: eachController model put: eachController roassalShape ] ].
	seenPairs := Set new.
	shapeByParticipantModel keysAndValuesDo: [ :sourceParticipant :sourceShape |
			sourceParticipant nodes select: #isActivity thenDo: [ :eachActivity |
					eachActivity sent do: [ :eachCommunication |
							| targetParticipant |
							targetParticipant := eachCommunication receiver participant.
							shapeByParticipantModel at: targetParticipant ifPresent: [ :targetShape |
									| pair |
									pair := sourceShape -> targetShape.
									(sourceShape ~~ targetShape and: [ (seenPairs includes: pair) not ]) ifTrue: [
											seenPairs add: pair.
											edges add: (RSLine new
													 from: sourceShape;
													 to: targetShape;
													 yourself) ] ] ] ] ].
	^ edges asGroup
]

{ #category : 'private' }
OPBormLayouter >> sortedTopLevelBoxes: aCollectionOfShapes [
	"Answers top level shapes ordered horizontally according to participant communication dependencies."

	| participantControllers ranks |
	participantControllers := aCollectionOfShapes
		collect: [ :eachShape |
			diagramController controllers
				detect: [ :eachController | eachController roassalShape == eachShape ]
				ifNone: [ nil ] ]
		thenSelect: [ :eachController |
			eachController isNotNil and: [ eachController isKindOf: OPBormParticipantController ] ].
	participantControllers ifEmpty: [ ^ aCollectionOfShapes ].

	ranks := self communicationRanksFor: participantControllers.

	^ aCollectionOfShapes asOrderedCollection sorted: [ :shapeA :shapeB |
		| controllerA controllerB rankA rankB |
		controllerA := diagramController controllers detect: [ :eachController | eachController roassalShape == shapeA ] ifNone: [ nil ].
		controllerB := diagramController controllers detect: [ :eachController | eachController roassalShape == shapeB ] ifNone: [ nil ].
		rankA := controllerA ifNotNil: [ ranks at: controllerA ifAbsent: [ Float infinity ] ] ifNil: [ Float infinity ].
		rankB := controllerB ifNotNil: [ ranks at: controllerB ifAbsent: [ Float infinity ] ] ifNil: [ Float infinity ].
		rankA < rankB ]
]
