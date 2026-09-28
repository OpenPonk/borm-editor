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
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
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
OPBormLayouterTest >> testAnchoredElementsExcludedFromTopLevelBoxes [
	| layouter topLevelBoxes |
	layouter := OPBormLayouter new diagramController: diagramController.
	topLevelBoxes := layouter topLevelNodeShapes.
	self assert: (topLevelBoxes noneSatisfy: [ :eachShape |
		(eachShape hasProperty: OPRSAnchorConstraint) or: [
			eachShape model owningElement isEdge ] ])
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
OPBormLayouterTest >> testParticipantEncompassesInnerNodesAfterDefaultLayout [
	| layouter participantControllers |
	layouter := OPBormLayouter new diagramController: diagramController.
	layouter defaultLayout.
	participantControllers := diagramController controllers select: [ :eachController |
		eachController isKindOf: OPBormParticipantController ].
	self assert: participantControllers isNotEmpty.
	participantControllers do: [ :eachParticipantController |
		| participantShape innerShapes |
		participantShape := eachParticipantController roassalShape.
		innerShapes := eachParticipantController diagramElement innerNodeRoassalShapes.
		innerShapes do: [ :eachInnerShape |
			self assert: (participantShape encompassingRectangle containsRect: eachInnerShape encompassingRectangle) ] ]
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
