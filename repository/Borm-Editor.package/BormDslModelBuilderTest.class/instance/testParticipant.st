tests
testParticipant
	| participant |
	participant := builder processLine: #('p1' #('my participant')).
	self assert: participant class equals: BormParticipant.
	self assert: participant name equals: 'my participant'.
	self assert: participant type equals: BormParticipantType Person.
	self assert: participant role equals: BormParticipantRole Undefined