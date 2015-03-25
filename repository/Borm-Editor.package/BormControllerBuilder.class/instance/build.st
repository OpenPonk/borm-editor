public
build
	diagramController ifNil: [ diagramController := self newDiagramControllerFor: diagram ].
	diagramController := self newDiagramControllerFor: diagram.
	diagramController view: view.
	self addParticipants: diagram participants.
	self addNodes: (self collectNodes: diagram participants).
	self addEdges: (self collectTransitions: diagram participants).
	self addEdges: (self collectCommunications: diagram participants).
	^ diagramController