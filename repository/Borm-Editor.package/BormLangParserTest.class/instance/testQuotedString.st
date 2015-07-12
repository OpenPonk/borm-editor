tests
testQuotedString
	self parse: '"quoted string"' rule: #quotedString.
	self assert: result equals: 'quoted string'.
	self fail: '''quoted string''' rule: #quotedString.
	self fail: '""' rule: #quotedString