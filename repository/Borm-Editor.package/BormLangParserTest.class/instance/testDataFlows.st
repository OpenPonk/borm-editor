tests
testDataFlows
	self parse: '' rule: #dataFlows.
	self assert: result equals: #().

	self parse: 'send "x" to "y"' rule: #dataFlows.
	self assert: result equals: #(#('send' 'x' 'y')).

	self parse: 'send "x" to "y" receive "k" from "l"' rule: #dataFlows.
	self assert: result equals: #(#('send' 'x' 'y') #('receive' 'k' 'l'))