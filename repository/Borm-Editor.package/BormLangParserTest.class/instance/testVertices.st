tests
testVertices
	self skip.
	self parse: '' rule: #nodes.
	self assert: result equals: #().

	self parse: self  resource emptyActivity rule: #nodes.
	self assert: result equals: {(self resource activityParsed)}.

	self parse: self resource fullActivity rule: #nodes.
	self assert: result equals: {(self resource fullActivityParsed)}.

	self parse: self resource emptyActivity , Character cr asString , self resource emptyActivity rule: #nodes.
	self
		assert: result
		equals:
			{(self resource activityParsed).
			(self resource activityParsed)}