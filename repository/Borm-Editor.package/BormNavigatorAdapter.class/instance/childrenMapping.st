widget API
childrenMapping
	^ {
	BormDiagram -> #participants.
	BormParticipant -> #nodes.	
	BormState -> #outgoing.
	BormActivity -> [ :o | o outgoing, o sent ].
	BormCommunication -> [ :o | o dataFlows, { o constraint } ].
	BormTransition -> [ :o | {o constraint} ]
	}