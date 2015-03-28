tests
testBlock
	| str participant |
	str := 'p1(''my participant'')
s1(s1, initial)
s1 -> a1
s2(s2, final)
a1 -> s2'.
	participant := builder parse: str.
	self assert: participant class equals: BormParticipant.
	self assert: participant name equals: 'my participant'.
	self assert: participant type equals: BormParticipantType Person.
	self assert: participant nodes size equals: 3