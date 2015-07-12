tests
testEmptyParticipant
	self parse: 'Organization "ORG" {}' rule: #participant.
	self assert: result equals: (Array with: 'Organization' with: 'ORG' -> nil)