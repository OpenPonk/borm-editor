construction
showInDiagram: aDiagramController
	super showInDiagram: aDiagramController.
	elements
		addAll:
			(self allOwnedElementsInModel
				collect: [ :each | (aDiagramController controllerForModel: each) figure ])