tests
testState
	super testState.
	self assert: result name equals: 'hello'.
	self deny: result isInitial.
	self deny: result isFinal