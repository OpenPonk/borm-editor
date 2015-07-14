tests
testCommunication
	super testCommunication.
	self assert: result receiver equals: 'Org::a'.
	self assert: result dataFlows size equals: 0