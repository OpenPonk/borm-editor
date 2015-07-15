tests
testState2
	super testState2.
	self assert: result name equals: 'hello'.
	self deny: result isInitial.
	self assert: result isFinal