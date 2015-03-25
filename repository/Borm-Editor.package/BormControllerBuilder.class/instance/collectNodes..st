private - collecting
collectNodes: participants
	^ (participants collect: [ :each | each nodes ]) flattened