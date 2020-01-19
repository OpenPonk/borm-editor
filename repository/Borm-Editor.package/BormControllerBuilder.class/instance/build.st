public
build
	diagramController
		ifNil: [ diagramController := self newDiagramControllerFor: diagram ].
	diagramController view: view.
	self halt.
	self addParticipants: diagram participants.
	self addNodes: (self collectNodes: diagram participants).
	self addEdges: (self collectTransitions: diagram participants).
	self addEdges: (self collectCommunications: diagram participants).
	self addDataFlows: (self collectDataFlows: diagram participants).
	^ diagramController