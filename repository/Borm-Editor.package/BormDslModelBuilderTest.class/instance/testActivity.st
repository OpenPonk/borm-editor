tests
testActivity
	| transition |
	transition := builder processLine: #('a1' '->>' 'a2').
	self assert: transition class equals: BormCommunication.
	self assert: transition source class equals: BormActivity.
	self assert: transition source name equals: 'a1'.
	self assert: transition target class equals: BormActivity.
	self assert: transition target name equals: 'a2'