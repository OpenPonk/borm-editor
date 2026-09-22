Class {
	#name : 'OPBormLayouterUndoTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'diagramController',
		'diagram',
		'model',
		'undoManager'
	],
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'running' }
OPBormLayouterUndoTest >> setUp [
	| projectController |
	super setUp.
	model := OPBormExampleDiagrams examplePizzaDelivery.
	project := OPProject new.
	project addModel: model.
	diagram := OPOpenPonkDiagram forModelElement: model.
	project addDiagram: diagram.

	undoManager := OPUndoManager new.
	projectController := OPProjectController forProject: project.
	projectController instVarNamed: #undoManager put: undoManager.

	diagramController := OPBormDiagramController new.
	projectController addDiagramController: diagramController.
	diagramController
		canvasPresenter: (OPCanvasPresenter new canvas: RSCanvas new; yourself);
		diagramElement: diagram;
		model: model.

	diagramController showAllElements
]

{ #category : 'as yet unclassified' }
OPBormLayouterUndoTest >> tearDown [
	undoManager := nil.
	diagramController := nil.
	diagram := nil.
	model := nil.
	project := nil.
	super tearDown
]

{ #category : 'tests' }
OPBormLayouterUndoTest >> testDefaultLayoutIsUndoable [
	| layouter boundElements initialPositions |
	layouter := OPBormLayouter new diagramController: diagramController.
	boundElements := (diagramController controllers
		select: [ :eachController | eachController diagramElement isKindOf: OPBoundNode ]
		thenCollect: #diagramElement) asSet.

	initialPositions := Dictionary new.
	boundElements do: [ :eachElement |
		eachElement roassalShape ifNotNil: [ :eachShape |
			initialPositions at: eachElement put: eachShape position copy ] ].

	layouter defaultLayout.

	self assert: undoManager canUndo.

	diagramController undo.

	boundElements do: [ :eachElement |
		eachElement roassalShape ifNotNil: [ :eachShape |
			self assert: eachShape position equals: (initialPositions at: eachElement) ] ]
]
