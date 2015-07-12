tests
testVertex
	self skip.
	self parse: self resource emptyActivity rule: #vertex.
	self assert: result equals: self resource activityParsed.
	self parse: self resource fullActivity rule: #vertex.
	self assert: result equals: self resource fullActivityParsed