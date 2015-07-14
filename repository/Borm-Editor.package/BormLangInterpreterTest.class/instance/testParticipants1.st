tests
testParticipants1
	super testParticipants1.
	self assert: result size equals: 1.
	self assert: result first name equals: 'Sys'.
	self assert: result first nodes size equals: 1