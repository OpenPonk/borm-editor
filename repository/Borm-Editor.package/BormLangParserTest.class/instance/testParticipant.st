tests
testParticipant
	super testParticipant.
	self assert: result type equals: BormParticipantType Person.
	self assert: result name equals: 'Customer'.
	self assert: result nodes size equals: 0