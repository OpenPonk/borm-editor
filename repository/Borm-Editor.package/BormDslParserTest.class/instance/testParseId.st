tests
testParseId
	self assertId: 'a1' equals: 'a1'.
	self assertId: 'p2.a2' equals: 'p2.a2'