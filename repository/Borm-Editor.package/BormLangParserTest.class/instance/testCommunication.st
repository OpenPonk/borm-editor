tests
testCommunication
	self parse: 'send "x" to "y"' rule: #communication.
	self assert: result equals: #('y' 'x' nil).

	self parse: 'send "x" to "y" and receive "z"' rule: #communication.
	self assert: result equals: #('y' 'x' 'z')