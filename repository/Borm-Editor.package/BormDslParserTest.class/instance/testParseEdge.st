tests
testParseEdge
	self assertEdge: 'a1 -> a2' equals: #('a1' '->' 'a2').
	self assertEdge: 'a1 ->> p2.a2' equals: #('a1' '->>' 'p2.a2' #()).
	self assertEdge: 'a1 ->> p2.a2 [(output), (input)]' equals: #('a1' '->>' 'p2.a2' #(#('output') #('input')))