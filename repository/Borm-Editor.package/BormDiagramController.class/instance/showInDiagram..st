rebuilding
showInDiagram: aDiagramController
	super showInDiagram: aDiagramController.
	self allRelationshipsInModel
		do: [ :each | aDiagramController showModelInDiagram: each ]