examples
examplePizzaDelivery2
	<example>
	('Person "Customer" {
	initial state "wants pizza"
		go to "order"
	
	activity "ordering pizza via phone" as "order"
		send "pizza description" to "Operator::accepting"
		go to "waiting"
	
	state "waiting"
		go to "accept"
	
	activity "accepts pizza and pays" as "accept"
		go to "complete"
	
	final state "purchase complete" as "complete"
}
System "Operator" {
	activity "processing order" as "accepting"
		go to "accept"
	
	state "order accepted" as "accept"
		go to "pass"
	
	activity "passes order" as "pass"
		go to "final"
	
	final state "order processed" as "final"
}

' asNewBorm: 'Pizza Delivery') openAs: 'Pizza Delivery'