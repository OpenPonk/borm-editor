tests
testDiagramWithDataFlows
	| arr participants communication |
	arr := {#('p1' #('pSource') #(#('a1' '->>' 'p2.a2' #(#('output') #('input'))))).
	#('p2' #('pTarget') #(#('a2' #('a2'))))}.
	participants := (builder processDiagram: arr) participants asSortedCollection: [ :a :b | a name < b name ].
	self assert: participants size equals: 2.

	self assert: participants first name equals: 'pSource'.
	self assert: participants first nodes size equals: 1.
	self assert: participants first nodes anyOne name equals: 'a1'.

	self assert: participants second name equals: 'pTarget'.
	self assert: participants second nodes size equals: 1.
	self assert: participants second nodes anyOne name equals: 'a2'.

	communication := participants first nodes anyOne sent anyOne.
	self assert: communication class equals: BormCommunication.
	self assert: communication sender equals: participants first nodes anyOne.
	self assert: communication receiver equals: participants second nodes anyOne.
	self assert: communication dataFlows size equals: 2