tests
testEmptyParticipants
	self parse: '' rule: #participants.
	self assert: result equals: #().

	self parse: 'Organization "ORG" {}' rule: #participants.
	self assert: result equals: {(Array with: 'Organization' with: 'ORG' -> nil)}.

	self parse: 'Organization "ORG" {} User "Customer" {}' rule: #participants.
	self
		assert: result
		equals:
			{(Array with: 'Organization' with: 'ORG' -> nil).
			(Array with: 'User' with: 'Customer' -> nil)}