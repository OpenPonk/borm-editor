tests
testVertex
	self skip.
	self parse: self resource emptyActivity rule: #node.
	self assert: result equals: self resource activityParsed.
	self parse: self resource fullActivity rule: #node.
	self assert: result equals: self resource fullActivityParsed