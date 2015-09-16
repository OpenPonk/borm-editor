as yet unclassified
constraintOnEdge: anElement
	| edge const |
	edge := (self diagramController controllerForModel: model owner) figure.
	anElement
		withViewDo:
			[ :view | 
			const := DCRTRailConstraint new.
			const
				initialPosition: 0.5;
				distance: 10.
			const element: anElement connection: edge ]