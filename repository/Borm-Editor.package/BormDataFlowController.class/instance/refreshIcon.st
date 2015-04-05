as yet unclassified
refreshIcon
	| edge right |
	edge := (self diagramController controllerForModel: model owner) figure.
	right := edge from position x < edge to position x.
	self model isOutput
		ifTrue: [ right := right not ].
	right
		ifTrue: [ iconFigure trachelShape form: BormEditorIcons current dataFlowRightIcon ]
		ifFalse: [ iconFigure trachelShape form: BormEditorIcons current dataFlowLeftIcon ]