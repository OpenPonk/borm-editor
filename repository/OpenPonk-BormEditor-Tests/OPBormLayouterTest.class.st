"
Tests automatic diagram layout and spatial routing of communication activities in BORM diagrams.
"
Class {
	#name : 'OPBormLayouterTest',
	#superclass : 'TestCase',
	#instVars : [
		'diagramController',
		'project',
		'model',
		'diagram'
	],
	#category : 'OpenPonk-BormEditor-Tests-Controllers',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'running' }
OPBormLayouterTest >> setUp [
	| projectController |
	super setUp.
	model := OPBormExamples examplePizzaDelivery.
	project := OPProject new.
	project addModel: model.
	diagram := OPOpenPonkDiagram forModelElement: model.
	project addDiagram: diagram.
	projectController := OPProjectController forProject: project.
	projectController instVarNamed: #undoManager put: OPUndoManager new.
	diagramController := OPBormDiagramController new.
	projectController addDiagramController: diagramController.
	diagramController
		canvasPresenter: (OPCanvasPresenter new canvas: RSCanvas new; yourself);
		diagramElement: diagram;
		model: model.
	diagramController showAllElements
]

{ #category : 'running' }
OPBormLayouterTest >> tearDown [
	diagramController := nil.
	diagram := nil.
	project := nil.
	model := nil.
	super tearDown
]

{ #category : 'tests' }
OPBormLayouterTest >> testAcyclicTreeSugiyamaAndDominanceTreeLayoutsKeepInnerNodesInside [

	| layouter participantControllers |
	layouter := OPBormLayouter new diagramController: diagramController.
	participantControllers := diagramController controllers select: [ :eachController |
		                          eachController isKindOf: OPBormParticipantController ].

	#( #treeLayout #sugiyamaLayout #dominanceTreeLayout ) do: [ :layoutSelector |
			layouter perform: layoutSelector.
			participantControllers do: [ :eachParticipantController |
					| participantShape |
					participantShape := eachParticipantController roassalShape.
					eachParticipantController diagramElement innerNodeRoassalShapes do: [ :eachInnerShape |
							self
								assert: (participantShape encompassingRectangle containsRect: eachInnerShape encompassingRectangle)
								description: 'Participant shape must encompass every inner node after hierarchical layout' ] ] ]
]

{ #category : 'tests' }
OPBormLayouterTest >> testAnchoredElementsExcludedFromTopLevelBoxes [

	| layouter topLevelBoxes anchoredBoxes |
	layouter := OPBormLayouter new diagramController: diagramController.
	topLevelBoxes := layouter topLevelNodeShapes.
	anchoredBoxes := topLevelBoxes select: [ :eachShape |
		                 (eachShape hasProperty: OPRSAnchorConstraint) or: [ eachShape model owningElement isEdge ] ].
	self assertEmpty: anchoredBoxes
]

{ #category : 'tests' }
OPBormLayouterTest >> testCommunicationRanksWithoutInitialStateAndWithDisconnectedOrHiddenParticipant [

	| customModel customProject customDiagram projectController customDiagramController senderParticipant receiverParticipant isolatedParticipant hiddenParticipant senderActivity receiverActivity hiddenActivity commToReceiver commToHidden layouter visibleControllers ranks |
	customModel := BormORModel named: 'Ranks'.
	senderParticipant := BormParticipant named: 'Sender'.
	receiverParticipant := BormParticipant named: 'Receiver'.
	isolatedParticipant := BormParticipant named: 'Isolated'.
	hiddenParticipant := BormParticipant named: 'Hidden'.
	senderActivity := BormActivity named: 'Send'.
	receiverActivity := BormActivity named: 'Receive'.
	hiddenActivity := BormActivity named: 'HiddenReceive'.
	senderParticipant add: senderActivity.
	receiverParticipant add: receiverActivity.
	hiddenParticipant add: hiddenActivity.
	commToReceiver := BormCommunication named: 'C1'.
	senderActivity send: commToReceiver.
	receiverActivity receive: commToReceiver.
	commToHidden := BormCommunication named: 'C2'.
	senderActivity send: commToHidden.
	hiddenActivity receive: commToHidden.
	customModel
		add: senderParticipant;
		add: receiverParticipant;
		add: isolatedParticipant;
		add: hiddenParticipant.
	customProject := OPProject new.
	customProject addModel: customModel.
	customDiagram := OPOpenPonkDiagram forModelElement: customModel.
	customProject addDiagram: customDiagram.
	projectController := OPProjectController forProject: customProject.
	projectController instVarNamed: #undoManager put: OPUndoManager new.
	customDiagramController := OPBormDiagramController new.
	projectController addDiagramController: customDiagramController.
	customDiagramController
		canvasPresenter: (OPCanvasPresenter new
				 canvas: RSCanvas new;
				 yourself);
		diagramElement: customDiagram;
		model: customModel.
	customDiagramController showAllElements.

	layouter := OPBormLayouter new diagramController: customDiagramController.
	self assertEmpty: (layouter communicationRanksFor: #(  )).

	visibleControllers := {
		                      (customDiagramController controllerForModel: senderParticipant).
		                      (customDiagramController controllerForModel: receiverParticipant).
		                      (customDiagramController controllerForModel: isolatedParticipant) }.
	ranks := layouter communicationRanksFor: visibleControllers.

	self assert: (ranks at: visibleControllers first) equals: 0.
	self assert: (ranks at: visibleControllers second) equals: 1.
	self assert: (ranks at: visibleControllers third) equals: 2
]

{ #category : 'tests' }
OPBormLayouterTest >> testCyclicParticipantLayoutIsIdempotentWithoutDrift [
	| cyclicModel cyclicProject cyclicDiagram projectCtrl cyclicDiagramCtrl layouter customerCtrl initialExtent extentAfterSecondLayout |
	cyclicModel := OPBormExamples exampleTravelingCard.
	cyclicProject := OPProject new.
	cyclicProject addModel: cyclicModel.
	cyclicDiagram := OPOpenPonkDiagram forModelElement: cyclicModel.
	cyclicProject addDiagram: cyclicDiagram.
	projectCtrl := OPProjectController forProject: cyclicProject.
	projectCtrl instVarNamed: #undoManager put: OPUndoManager new.
	cyclicDiagramCtrl := OPBormDiagramController new.
	projectCtrl addDiagramController: cyclicDiagramCtrl.
	cyclicDiagramCtrl
		canvasPresenter: (OPCanvasPresenter new canvas: RSCanvas new; yourself);
		diagramElement: cyclicDiagram;
		model: cyclicModel.
	cyclicDiagramCtrl showAllElements.

	layouter := OPBormLayouter new diagramController: cyclicDiagramCtrl.
	layouter defaultLayout.

	customerCtrl := cyclicDiagramCtrl controllers detect: [ :eachController |
		(eachController isKindOf: OPBormParticipantController) and: [ eachController model name = 'Customer' ] ].
	initialExtent := customerCtrl roassalShape extent.

	layouter defaultLayout.
	extentAfterSecondLayout := customerCtrl roassalShape extent.

	self assert: initialExtent equals: extentAfterSecondLayout
]

{ #category : 'tests' }
OPBormLayouterTest >> testCyclicTreeLayoutFallsBackCleanlyWithoutLeakingSubscriptions [

	| cyclicModel cyclicProject cyclicDiagram projectController cyclicDiagramController layouter participantControllers |
	cyclicModel := OPBormExamples exampleTravelingCard.
	cyclicProject := OPProject new.
	cyclicProject addModel: cyclicModel.
	cyclicDiagram := OPOpenPonkDiagram forModelElement: cyclicModel.
	cyclicProject addDiagram: cyclicDiagram.
	projectController := OPProjectController forProject: cyclicProject.
	projectController instVarNamed: #undoManager put: OPUndoManager new.
	cyclicDiagramController := OPBormDiagramController new.
	projectController addDiagramController: cyclicDiagramController.
	cyclicDiagramController
		canvasPresenter: (OPCanvasPresenter new
				 canvas: RSCanvas new;
				 yourself);
		diagramElement: cyclicDiagram;
		model: cyclicModel.
	cyclicDiagramController showAllElements.

	layouter := OPBormLayouter new diagramController: cyclicDiagramController.
	layouter treeLayout.

	participantControllers := cyclicDiagramController controllers select: [ :eachController |
		                          eachController isKindOf: OPBormParticipantController ].
	self denyEmpty: participantControllers.
	participantControllers do: [ :eachParticipantController |
			| participantShape layouterSubscriptions |
			participantShape := eachParticipantController roassalShape.
			layouterSubscriptions := participantShape announcer subscriptions subscriptions select: [ :eachSubscription |
				                         eachSubscription subscriber == layouter ].
			self assertEmpty: layouterSubscriptions.
			eachParticipantController diagramElement innerNodeRoassalShapes do: [ :eachInnerShape |
					self
						assert: (participantShape encompassingRectangle containsRect: eachInnerShape encompassingRectangle)
						description: 'Participant shape must encompass every inner node after cyclic tree layout fallback' ] ]
]

{ #category : 'tests' }
OPBormLayouterTest >> testGridLayoutArrangesParticipantsInMultipleRowsAndKeepsInnerNodesInside [

	| layouter participantControllers participantBoxes distinctTops |
	layouter := OPBormLayouter new diagramController: diagramController.
	layouter gridLayout.

	participantControllers := diagramController controllers select: [ :eachController |
		                          eachController isKindOf: OPBormParticipantController ].
	participantBoxes := participantControllers collect: #roassalShape.
	distinctTops := participantBoxes collect: [ :eachShape | eachShape encompassingRectangle top rounded ] as: Set.

	self assert: distinctTops size > 1 description: 'Grid layout must arrange 5 participants into more than one row'.

	participantControllers do: [ :eachParticipantController |
			| participantShape |
			participantShape := eachParticipantController roassalShape.
			eachParticipantController diagramElement innerNodeRoassalShapes do: [ :eachInnerShape |
					self
						assert: (participantShape encompassingRectangle containsRect: eachInnerShape encompassingRectangle)
						description: 'Participant shape must encompass every inner node after grid layout' ] ]
]

{ #category : 'tests' }
OPBormLayouterTest >> testLayoutCommandExecutesDefaultLayoutAndAllNodesReturnsRenderedShapes [

	| layouter command |
	layouter := OPBormLayouter new diagramController: diagramController.
	self assertCollection: layouter allNodes hasSameElements: layouter allRenderedNodeShapes.

	command := OPBormLayoutCommand new.
	command instVarNamed: #layouter put: layouter.
	command execute.

	self assert: command defaultMenuItemName equals: 'Process Flow'
]

{ #category : 'tests' }
OPBormLayouterTest >> testLayoutCommunicationSkipsCommunicationWithoutShownDataFlows [

	| layouter emptyCommunication |
	layouter := OPBormLayouter new diagramController: diagramController.
	emptyCommunication := BormCommunication named: 'Empty'.
	self assert: (layouter layoutCommunication: emptyCommunication) identicalTo: layouter
]

{ #category : 'tests' }
OPBormLayouterTest >> testParticipantEncompassesInnerNodesAfterDefaultLayout [

	| layouter participantControllers |
	layouter := OPBormLayouter new diagramController: diagramController.
	layouter defaultLayout.
	participantControllers := diagramController controllers select: [ :eachController |
		                          eachController isKindOf: OPBormParticipantController ].
	self denyEmpty: participantControllers.
	participantControllers do: [ :eachParticipantController |
			| participantShape innerShapes |
			participantShape := eachParticipantController roassalShape.
			innerShapes := eachParticipantController diagramElement innerNodeRoassalShapes.
			innerShapes do: [ :eachInnerShape |
					self
						assert: (participantShape encompassingRectangle containsRect: eachInnerShape encompassingRectangle)
						description: 'Participant shape must encompass every inner node shape' ] ]
]

{ #category : 'tests' }
OPBormLayouterTest >> testParticipantLayoutIsIdempotentWithoutDrift [
	| layouter participantController initialExtent extentAfterSecondLayout |
	layouter := OPBormLayouter new diagramController: diagramController.
	layouter defaultLayout.
	participantController := diagramController controllers detect: [ :eachController |
		eachController isKindOf: OPBormParticipantController ].
	initialExtent := participantController roassalShape extent.
	layouter defaultLayout.
	extentAfterSecondLayout := participantController roassalShape extent.
	self assert: initialExtent equals: extentAfterSecondLayout
]

{ #category : 'tests' }
OPBormLayouterTest >> testParticipantsOrderedByCommunicationFlow [
	| layouter participantBoxes participantNames |
	layouter := OPBormLayouter new diagramController: diagramController.
	layouter defaultLayout.
	participantBoxes := (layouter topLevelNodeShapes select: [ :eachShape |
		(diagramController controllers detect: [ :eachCtrl | eachCtrl roassalShape == eachShape ]) isKindOf: OPBormParticipantController ])
			asOrderedCollection sorted: [ :shapeA :shapeB | shapeA position x < shapeB position x ].
	participantNames := participantBoxes collect: [ :eachShape |
		(diagramController controllers detect: [ :eachCtrl | eachCtrl roassalShape == eachShape ]) model name ].
	self assert: participantNames asArray equals: #( 'Customer' 'Operator' 'Kitchen' 'Delivery Boy' 'Cashier' )
]

{ #category : 'tests' }
OPBormLayouterTest >> testSortedTopLevelBoxesWithNonParticipantShapes [

	| layouter orphanBox participantBoxes nonParticipantShape mixedInput sortedMixed |
	layouter := OPBormLayouter new diagramController: diagramController.
	orphanBox := RSBox new.
	self assert: (layouter sortedTopLevelBoxes: { orphanBox }) equals: { orphanBox }.

	participantBoxes := layouter topLevelNodeShapes.
	nonParticipantShape := (diagramController controllers detect: [ :eachController | eachController isKindOf: OPBormStateController ])
		                       roassalShape.
	mixedInput := {
		              orphanBox.
		              nonParticipantShape } , participantBoxes asArray.
	sortedMixed := layouter sortedTopLevelBoxes: mixedInput.

	self assert: sortedMixed size equals: mixedInput size.
	self assertCollection: (sortedMixed last: 2) hasSameElements: {
			orphanBox.
			nonParticipantShape }
]
