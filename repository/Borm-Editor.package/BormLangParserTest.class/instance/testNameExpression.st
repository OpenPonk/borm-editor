tests
testNameExpression
	self parse: '"name"' rule: #nameExpression.
	self assert: result equals: 'name' -> nil.

	self parse: '"name" as "alias"' rule: #nameExpression.
	self assert: result equals: 'name' -> 'alias'