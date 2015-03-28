tests
testParticipant2
	| participant |
	participant := builder processLine: #('p1' #('my participant' 'System' 'Cooperates')).
	self assert: participant class equals: BormParticipant.
	self assert: participant name equals: 'my participant'.
	self assert: participant type equals: BormParticipantType System.
	self assert: participant role equals: BormParticipantRole Cooperates