tests
testString
	self parse: 'some string' rule: #string.
	self assert: result equals: 'some string'.
	self fail: '' rule: #string