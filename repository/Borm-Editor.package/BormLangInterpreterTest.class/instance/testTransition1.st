tests
testTransition1
	super testTransition1.
	self assert: result target equals: 'vertex'.
	self assert: result constraint name equals: 'condition'