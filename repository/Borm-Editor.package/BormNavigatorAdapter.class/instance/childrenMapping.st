widget API
childrenMapping
	^ {
	BormDiagram -> #participants.
	BormParticipant -> #nodes.	
	BormState -> #outgoing.
	BormActivity -> [ :o | o outgoing, o sent ].
	BormCommunication -> #dataFlows.
	}