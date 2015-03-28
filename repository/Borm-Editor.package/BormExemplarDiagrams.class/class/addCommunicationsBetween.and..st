adding
addCommunicationsBetween: leftParticipant and: rightParticipant
	| l1 l2 r1 r2 |
	l1 := leftParticipant nodes detect: [ :each | each name = 'a1' ].
	l2 := leftParticipant nodes detect: [ :each | each name = 'a2' ].

	r1 := rightParticipant nodes detect: [ :each | each name = 'a1' ].
	r2 := rightParticipant nodes detect: [ :each | each name = 'a2' ].

	self bormEdgeFrom: l1 to: r1 with: BormCommunication.
	self bormEdgeFrom: r2 to: l2 with: BormCommunication