tests
testState2
	| state |
	state := builder processLine: #('s1' #('first state' 'final' 'initial')).
	self assert: state class equals: BormState.
	self assert: state name equals: 'first state'.
	self assert: state isInitial.
	self assert: state isFinal