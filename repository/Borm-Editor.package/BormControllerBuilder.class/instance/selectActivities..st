private - collecting
selectActivities: nodes
	^ nodes select: [ :node | node isKindOf: BormActivity ]