tests
testDataFlow
	self parse: 'send "x" to "y"' rule: #dataFlow.
	self assert: result equals: #('send' 'x' 'y').

	self parse: 'receive "x" from "y"' rule: #dataFlow.
	self assert: result equals: #('receive' 'x' 'y')