tests
testState1
	super testState1.
	self assert: result name equals: 'hello'.
	self assert: result isInitial.
	self deny: result isFinal