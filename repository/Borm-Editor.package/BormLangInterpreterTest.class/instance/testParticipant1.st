tests
testParticipant1
	super testParticipant1.
	self assert: result type equals: BormParticipantType System.
	self assert: result name equals: 'Sys'.
	self assert: result nodes size equals: 1