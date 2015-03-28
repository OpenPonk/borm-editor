tests
testParseSpecification
	self assertSpecification: 'abc(param1)' equals: #('abc' #('param1')).
	self assertSpecification: 'abc(''param1'')' equals: #('abc' #('param1')).
	self assertSpecification: 'abc(param1, param2)' equals: #('abc' #('param1' 'param2')).
	self assertSpecification: 'abc(''param1'', param2)' equals: #('abc' #('param1' 'param2')).
	self assertSpecification: 'abc(param1, ''param2'')' equals: #('abc' #('param1' 'param2')).
	self assertSpecification: 'abc(''param1'', ''param2'')' equals: #('abc' #('param1' 'param2')).
	self assertSpecification: 'abc(''param1, param2'')' equals: #('abc' #('param1, param2'))