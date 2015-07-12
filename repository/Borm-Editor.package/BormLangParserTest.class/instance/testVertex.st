tests
testVertex
	self parse: self emptyActivity rule: #vertex.
	self assert: result equals: self activityVertexParsed.
	self parse: self fullActivity rule: #vertex.
	self assert: result equals: self fullActivityParsed