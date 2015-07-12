tests
testParticipantType
	self parse: 'User' rule: #participantType.
	self assert: result equals: 'User'.
	self parse: 'Organization' rule: #participantType.
	self assert: result equals: 'Organization'.
	self fail: 'Whatever' rule: #participantType