private
constraintOnEdge: anElement
	| edge cb const |
	edge := (self diagramController controllerForModel: model owner) figure.
	const := OPRTRailConstraint new.
	const
		initialPosition: 0.5;
		distance: 10.
	const element: anElement connection: edge.

	cb := TRTranslationCallback block: [ self refreshIcon ].
	edge from addCallback: cb.
	edge to addCallback: cb.
	anElement
		addCallback:
			(TRRemoveCallback
				block:
					[ 
					edge from trachelShape removeCallback: cb ifAbsent: [ self error ].
					edge to trachelShape removeCallback: cb ifAbsent: [ self error ] ])