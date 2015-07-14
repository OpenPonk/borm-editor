tests
testNode1
	super testNode1.
	self assert: result outgoing size equals: 1.
	self assert: result outgoing first source equals: result