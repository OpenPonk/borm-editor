tests
testCommunication1
	super testCommunication1.
	self assert: result receiver equals: 'Org::a'.
	self assert: result dataFlows size equals: 1.
	self assert: result dataFlows first name equals: 'x'.
	self assert: result dataFlows first isInput