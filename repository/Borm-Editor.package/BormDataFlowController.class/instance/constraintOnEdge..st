private
constraintOnEdge: anElement
	| edge cb |
	edge := (self diagramController controllerForModel: model owner) figure.
	DCRTEdgeAlongConstraint
		stick: anElement
		alongEdge: edge
		balance: 0.5
		offset: 0.
	cb := TRTranslationCallback block: [ self refreshIcon ].
	edge from addCallback: cb.
	edge to addCallback: cb.
	anElement
		addCallback:
			(TRRemoveCallback
				block: [ 
					edge from trachelShape removeCallback: cb ifAbsent: [ self error ].
					edge to trachelShape removeCallback: cb ifAbsent: [ self error ] ])