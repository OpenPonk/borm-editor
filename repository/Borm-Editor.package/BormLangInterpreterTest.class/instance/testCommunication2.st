tests
testCommunication2
	super testCommunication2.
	self assert: result receiver equals: 'Org::a'.
	self assert: result dataFlows size equals: 2.
	self assert: result dataFlows first name equals: 'x'.
	self assert: result dataFlows first isInput.
	self assert: result dataFlows second name equals: 'y'.
	self assert: result dataFlows second isOutput