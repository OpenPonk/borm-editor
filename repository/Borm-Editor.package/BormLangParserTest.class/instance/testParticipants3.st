tests
testParticipants3
	super testParticipants3.
	self assert: result size equals: 2.
	self assert: result first nodes size equals: 2.
	self assert: result first nodes first outgoing first target equals: result first nodes second.
	self assert: result second nodes size equals: 2.
	self assert: result second nodes first outgoing first target equals: result second nodes second