tests
testDataFlows
	| communication flows |
	communication := builder processLine: #('a1' '->>' 'a2' #(#('input') #('output'))).

	self assert: communication dataFlows size equals: 2.
	flows := communication dataFlows asSortedCollection: [ :a :b | a name < b name ].

	self assert: flows first name equals: 'input'.
	self assert: flows first isInput.

	self assert: flows second name equals: 'output'.
	self assert: flows second isOutput