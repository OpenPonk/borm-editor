steps
step2
	self start: 'Operator' at: 'processing order'.
	self
		send: 'pizza description'
		from: 'Customer::ordering pizza via phone'
		to: 'Operator::processing order'