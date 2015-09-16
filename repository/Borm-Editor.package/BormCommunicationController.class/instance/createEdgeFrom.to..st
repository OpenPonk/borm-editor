hooks
createEdgeFrom: fromElement to: toElement
	| edge |
	^ DCRTCallbackBuilder
		block: [ :view | 
			edge := DCRTStyledConnection new
				withContinuousRectangleAttachPoint;
				color: Color black;
				arrowHead;
				edgeFrom: fromElement to: toElement.
			edge @ DCRTConnectionHandles.
			view add: edge.
			edge trachelShape pushFront.
			edge ]