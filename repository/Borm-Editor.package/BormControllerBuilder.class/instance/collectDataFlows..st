private - collecting
collectDataFlows: participants
	^ ((self collectCommunications: participants) collect: [ :comm | comm dataFlows ]) flattened