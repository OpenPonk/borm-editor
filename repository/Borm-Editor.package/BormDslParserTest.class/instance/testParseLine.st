tests
testParseLine
	self assertLine: 'a1 -> a2' equals: #('a1' '->' 'a2').
	self assertLine: 'abc(param1)' equals: #('abc' #('param1'))