as yet unclassified
layoutNode: aNode
	| figure bounds |
	figure := (diagramController controllerForModel: aNode) figure.
	bounds := figure encompassingRectangle.
	bounds := bounds
		merge:
			((figure isKindOf: BormNodeFigure)
				ifTrue: [ figure text encompassingRectangle ]
				ifFalse: [ (figure attributeAt: #RTLabelledLabel) encompassingRectangle ]).
	RTNest new resizeWithoutRecursion: figure bounds: bounds