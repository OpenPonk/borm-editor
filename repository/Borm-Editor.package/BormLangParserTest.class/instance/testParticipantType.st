tests
testParticipantType
	self parse: 'Person' rule: #participantType.
	self assert: result equals: 'Person'.
	self parse: 'Organization' rule: #participantType.
	self assert: result equals: 'Organization'.
	self fail: 'Whatever' rule: #participantType