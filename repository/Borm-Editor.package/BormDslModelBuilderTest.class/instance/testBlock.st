tests
testBlock
	| arr participant |
	arr := {'p1'.
	#('my participant').
	{#('s1' #('s1' 'p1' #initial)).
	#('s1' '->' 'a1').
	#('s2' #('s2' 'final')).
	#('a1' '->' 's2')}}.
	participant := builder processBlock: arr.
	self assert: participant class equals: BormParticipant.
	self assert: participant name equals: 'my participant'.
	self assert: participant type equals: BormParticipantType Person.
	self assert: participant nodes size equals: 3