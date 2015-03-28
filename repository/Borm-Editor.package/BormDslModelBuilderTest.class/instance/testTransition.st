tests
testTransition
	| transition |
	transition := builder processLine: #('s1' '->' 'a1').
	self assert: transition class equals: BormTransition.
	self assert: transition source class equals: BormState.
	self assert: transition source name equals: 's1'.
	self assert: transition target class equals: BormActivity.
	self assert: transition target name equals: 'a1'