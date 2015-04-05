private
constraintOnEdge: anElement
	| edge cb |
	edge := (self diagramController controllerForModel: model owner) figure.
	DCRTEdgeAlongConstraint
		stick: anElement
		alongEdge: edge
		balance: 0.5
		offset: 0.
	cb := TRTranslationCallback
		block: [ 
			| right |
			right := edge from position x < edge to position x.
			self model isOutput
				ifTrue: [ right := right not ].
			right
				ifTrue: [ iconFigure trachelShape form: BormEditorIcons current dataFlowRightIcon ]
				ifFalse: [ iconFigure trachelShape form: BormEditorIcons current dataFlowLeftIcon ] ].
	edge from addCallback: cb.
	edge to addCallback: cb