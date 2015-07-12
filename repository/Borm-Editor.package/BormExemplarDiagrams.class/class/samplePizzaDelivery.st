samples
samplePizzaDelivery
	<sample>
	| diagram factory |
	diagram := self samplePizzaDeliveryBase.
	(factory := BormModelFactory new) diagram: diagram.
	(factory communicationFromFqn: 'Customer::ordering pizza via phone' toFqn: 'Operator::processing order')
		addDataFlow: (BormDataFlow named: 'pizza description').
	^ diagram