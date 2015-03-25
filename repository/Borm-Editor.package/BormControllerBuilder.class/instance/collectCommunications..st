private - collecting
collectCommunications: participants
	^ ((self selectActivities: (self collectNodes: participants)) collect: [ :activity | activity sent ]) flattened