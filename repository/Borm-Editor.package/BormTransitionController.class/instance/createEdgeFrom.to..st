hooks
createEdgeFrom: fromElement to: toElement
	| builder edge |
	^ DCRTCallbackBuilder
		block: [ :view | 
			builder := DCRTEdgeBuilder new.
			builder filledNarrowArrowHead.
			edge := builder createEdgeFrom: fromElement to: toElement.
			view add: edge.
			edge ]