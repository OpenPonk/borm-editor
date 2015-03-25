private - factories
newDiagramControllerFor: aDiagram
	^ BormDiagramController new
		model: aDiagram;
		yourself