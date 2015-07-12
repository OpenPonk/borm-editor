tests
testCommunications
	self
		parse:
			'send "x" to "y"
send "x" to "y" and receive "z"'
		rule: #communications.
	self
		assert: result
		equals:
			{#('y' 'x' nil).
			#('y' 'x' 'z')}