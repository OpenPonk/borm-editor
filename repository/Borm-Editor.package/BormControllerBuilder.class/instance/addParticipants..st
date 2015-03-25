private - building
addParticipants: participants
	participants do: [ :p | diagramController addAsTargetFor: (self newControllerFor: p) ]