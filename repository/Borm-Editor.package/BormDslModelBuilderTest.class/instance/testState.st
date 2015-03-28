tests
testState
	| state |
	state := builder processLine: #('s1' #('first state')).
	self assert: state class equals: BormState.
	self assert: state name equals: 'first state'.
	self deny: state isInitial.
	self deny: state isFinal