hooks
createEdgeFrom: fromElement to: toElement
	| edge |
	^ DCRTCallbackBuilder
		block: [ :view | 
			edge := DCRTNewMultiLine new
				withContinuousRectangleAttachPoint;
				color: Color black;
				arrowHead;
				edgeFrom: fromElement to: toElement.
			edge @ DCRTLineHandles.
			view add: edge.
			edge trachelShape pushBack.
			edge ]