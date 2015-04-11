as yet unclassified
constraintOnEdge: anElement
	| edge |
	edge := (self diagramController controllerForModel: model owner) figure.
	DCRTEdgeAlongConstraint
		stick: anElement
		alongEdge: edge
		balance: 0.5
		offset: 0