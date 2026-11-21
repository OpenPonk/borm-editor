"
Verifies transactional undo and redo support for automatic layout commands in BORM diagrams.
"
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
	#category : 'OpenPonk-BormEditor-Tests-Controllers',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'running' }
OPBormLayouterUndoTest >> setUp [
	| projectController |
	super setUp.
	model := OPBormExamples examplePizzaDelivery.
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

{ #category : 'running' }
OPBormLayouterUndoTest >> tearDown [

	undoManager := nil.
	diagramController := nil.
	diagram := nil.
	model := nil.
	project := nil.
	super tearDown
]

{ #category : 'tests' }
OPBormLayouterUndoTest >> testCyclicTreeLayoutIsUndoableToInitialPositions [

	| cyclicModel cyclicProject cyclicDiagram cyclicUndoManager projectController cyclicDiagramController layouter boundElements initialPositions |
	cyclicModel := OPBormExamples exampleTravelingCard.
	cyclicProject := OPProject new.
	cyclicProject addModel: cyclicModel.
	cyclicDiagram := OPOpenPonkDiagram forModelElement: cyclicModel.
	cyclicProject addDiagram: cyclicDiagram.
	cyclicUndoManager := OPUndoManager new.
	projectController := OPProjectController forProject: cyclicProject.
	projectController instVarNamed: #undoManager put: cyclicUndoManager.
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
	boundElements := (cyclicDiagramController controllers
		                  select: [ :eachController | eachController diagramElement isKindOf: OPBoundNode ]
		                  thenCollect: #diagramElement) asSet.
	self denyEmpty: boundElements.

	initialPositions := Dictionary new.
	boundElements do: [ :eachElement | initialPositions at: eachElement put: eachElement roassalShape position copy ].

	layouter treeLayout.

	self assert: cyclicUndoManager canUndo description: 'Cyclic tree layout fallback must push an undoable command onto undoManager'.

	cyclicDiagramController undo.

	boundElements do: [ :eachElement | self assert: eachElement roassalShape position equals: (initialPositions at: eachElement) ]
]

{ #category : 'tests' }
OPBormLayouterUndoTest >> testDefaultLayoutIsUndoable [

	| layouter boundElements initialPositions |
	layouter := OPBormLayouter new diagramController: diagramController.
	boundElements := (diagramController controllers
		                  select: [ :eachController | eachController diagramElement isKindOf: OPBoundNode ]
		                  thenCollect: #diagramElement) asSet.
	self denyEmpty: boundElements.

	initialPositions := Dictionary new.
	boundElements do: [ :eachElement |
			| eachShape |
			eachShape := eachElement roassalShape.
			self deny: eachShape identicalTo: nil.
			initialPositions at: eachElement put: eachShape position copy ].

	layouter defaultLayout.

	self assert: undoManager canUndo description: 'Default layout must push an undoable command onto undoManager'.

	diagramController undo.

	boundElements do: [ :eachElement |
			| eachShape |
			eachShape := eachElement roassalShape.
			self deny: eachShape identicalTo: nil.
			self assert: eachShape position equals: (initialPositions at: eachElement) ]
]
