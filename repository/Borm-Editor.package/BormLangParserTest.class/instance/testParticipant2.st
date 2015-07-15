tests
testParticipant2
	super testParticipant2.
	self assert: result type equals: BormParticipantType Organization.
	self assert: result name equals: 'Org'.
	self assert: result nodes size equals: 2