hooks
createEdgeFrom: fromElement to: toElement
	| builder edge |
	^ DCRTCallbackBuilder
		block: [ :view | 
			builder := DCRTEdgeBuilder new.
			(self model target isKindOf: BormState)
				ifTrue: [ builder filledNarrowArrowHead ].
			builder lineWidth: 2.
			edge := builder createEdgeFrom: fromElement to: toElement.
			view add: edge.
			edge ]