hooks
createEdgeFrom: fromElement to: toElement
	| edge |
	^ OPRTCallbackBuilder
		block: [ :view | 
			edge := OPRTStyledConnection new
				withBorderAttachPoint;
				color: Color black;
				edgeFrom: fromElement to: toElement.
			edge shape decorations arrowHead.
			edge @ OPRTConnectionHandles.
			view add: edge.
			edge trachelShape pushFront.
			edge ]