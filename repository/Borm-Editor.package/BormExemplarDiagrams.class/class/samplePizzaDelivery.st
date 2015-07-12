samples
samplePizzaDelivery
	<sample>
	| diagram |
	diagram := self samplePizzaDeliveryBase.
	diagram @ 'Customer::ordering pizza via phone' ==> (diagram @ 'Operator::processing order')
		addDataFlowNamed: 'pizza description'.

	diagram @ 'Operator::passes order' ==> (diagram @ 'Kitchen::accepts order') addDataFlowNamed: 'order'.

	diagram @ 'Kitchen::hands over pizza' ==> (diagram @ 'Delivery Boy::takes pizza') addDataFlowNamed: 'pizza'.

	diagram @ 'Delivery Boy::delivers pizza' ==> (diagram @ 'Customer::accepts pizza and pays')
		addDataFlowNamed: 'pizza';
		addDataFlow:
				((BormDataFlow named: 'money')
						beOutput;
						yourself).

	diagram @ 'Delivery Boy::gives money to cashier' ==> (diagram @ 'Cashier::accepts money') addDataFlowNamed: 'money'.

	^ diagram