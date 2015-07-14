tests
testParticipant3
	super testParticipant3.
	self assert: result nodes size equals: 2.
	self assert: result nodes first outgoing first target equals: result nodes second