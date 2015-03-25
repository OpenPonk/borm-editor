private - collecting
collectTransitions: participants
	^ ((self collectNodes: participants) collect: [ :node | node outgoing ]) flattened