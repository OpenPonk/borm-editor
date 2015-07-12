tests
testVertices
	self parse: '' rule: #vertices.
	self assert: result equals: #().

	self parse: self emptyActivity rule: #vertices.
	self assert: result equals: {(self activityVertexParsed)}.

	self parse: self fullActivity rule: #vertices.
	self assert: result equals: {(self fullActivityParsed)}.

	self parse: self emptyActivity , Character cr asString , self emptyActivity rule: #vertices.
	self
		assert: result
		equals:
			{(self activityVertexParsed).
			(self activityVertexParsed)}