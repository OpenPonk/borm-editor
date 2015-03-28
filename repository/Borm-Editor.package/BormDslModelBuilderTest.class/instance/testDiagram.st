tests
testDiagram
	| arr participants |
	arr := {#('p1' #('my participant') #(#('s1' '->' 'a1'))).
	#('p2' #('second') #(#('s2' '->' 'a2')))}.
	participants := (builder processDiagram: arr) participants asSortedCollection: [ :a :b | a name < b name ].
	self assert: participants size equals: 2.

	self assert: participants first class equals: BormParticipant.
	self assert: participants first name equals: 'my participant'.
	self assert: participants first nodes size equals: 2.

	self assert: participants second class equals: BormParticipant.
	self assert: participants second name equals: 'second'.
	self assert: participants second nodes size equals: 2