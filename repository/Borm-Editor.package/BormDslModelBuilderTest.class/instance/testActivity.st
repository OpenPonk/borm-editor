tests
testActivity
	| communication |
	communication := builder processLine: #('a1' '->>' 'a2' #()).
	self assert: communication class equals: BormCommunication.
	self assert: communication source class equals: BormActivity.
	self assert: communication source name equals: 'a1'.
	self assert: communication target class equals: BormActivity.
	self assert: communication target name equals: 'a2'.
	self assert: communication dataFlows isEmpty.