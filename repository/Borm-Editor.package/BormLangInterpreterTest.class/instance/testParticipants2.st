tests
testParticipants2
	super testParticipants2.
	self assert: result size equals: 2.
	self assert: result first name equals: 'Sys'.
	self assert: result first nodes size equals: 1.
	self assert: result second name equals: 'Org'.
	self assert: result second nodes size equals: 1