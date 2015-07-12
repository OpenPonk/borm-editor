tests
testState
	self parse: 'state "hello"' rule: #state.
	self
		assert: result
		equals:
			{'state'.
			nil.
			('hello' -> nil)}