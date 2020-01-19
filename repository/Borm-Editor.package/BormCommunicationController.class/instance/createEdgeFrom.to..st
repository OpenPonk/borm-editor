hooks
createEdgeFrom: fromElement to: toElement
	| edge |
	edge := OPRTStyledConnection new
		withBorderAttachPoint;
		color: Color black;
		edgeFrom: fromElement to: toElement.
	edge shape decorations arrowHead.
	^ edge