tests
testState3
	super testState3.
	self assert: result name equals: 'hello'.
	self assert: result isInitial.
	self assert: result isFinal