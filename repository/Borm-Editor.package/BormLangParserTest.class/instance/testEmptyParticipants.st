tests
testEmptyParticipants
	self parse: '' rule: #participants.
	self assert: result equals: #().

	self parse: 'Organization "ORG" {
}' rule: #participants.
	self assert: result equals: {(Array with: 'Organization' with: 'ORG' -> nil with: #())}.

	self parse: 'Organization "ORG" {
} Person "Customer" {
}' rule: #participants.
	self
		assert: result
		equals:
			{(Array with: 'Organization' with: 'ORG' -> nil with: #()).
			(Array with: 'Person' with: 'Customer' -> nil with: #())}