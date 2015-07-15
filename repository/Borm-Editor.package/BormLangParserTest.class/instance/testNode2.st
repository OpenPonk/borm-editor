tests
testNode2
	super testNode2.
	self assert: result outgoing size equals: 2.
	result outgoing do: [ :each | self assert: each source equals: result ]