hooks
createEdgeFrom: fromElement to: toElement
	| edge shape |
	shape := OPRTStyledConnection new
		withBorderAttachPoint;
		color: Color black;
		width: 2.
	(self model target isKindOf: BormState)
		ifTrue: [ shape decorations filledNarrowArrowHead ].
	edge := shape edgeFrom: fromElement to: toElement.
	^ edge