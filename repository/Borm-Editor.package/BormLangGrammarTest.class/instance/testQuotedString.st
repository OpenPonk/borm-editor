tests
testQuotedString
	self parse: '"quoted string"' rule: #name.
	self assert: result equals: 'quoted string'.
	self fail: '''quoted string''' rule: #name.
	self fail: '""' rule: #name