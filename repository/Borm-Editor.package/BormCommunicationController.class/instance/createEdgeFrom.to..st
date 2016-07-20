hooks
createEdgeFrom: fromElement to: toElement
	| edge |
	^ DCRTCallbackBuilder
		block: [ :view | 
			edge := DCRTStyledConnection new
				withBorderAttachPoint;
				color: Color black;
				edgeFrom: fromElement to: toElement.
			edge shape decorations arrowHead.
			edge @ DCRTConnectionHandles.
			view add: edge.
			edge trachelShape pushFront.
			edge ]