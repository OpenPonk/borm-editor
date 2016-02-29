steps
step4
	self start: 'Kitchen' at: 'accepts order'.
	self move: 'Operator' from: 'order accepted' to: 'passes order'.
	self
		send: 'order'
		from: 'Operator::passes order'
		to: 'Kitchen::accepts order'