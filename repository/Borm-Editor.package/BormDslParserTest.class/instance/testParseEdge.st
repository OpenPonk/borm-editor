tests
testParseEdge
	self assertEdge: 'a1 -> a2' equals: #('a1' '->' 'a2').
	self assertEdge: 'a1 ->> a2' equals: #('a1' '->>' 'a2')