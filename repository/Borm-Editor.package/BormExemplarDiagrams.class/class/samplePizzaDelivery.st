samples
samplePizzaDelivery
	<sample>
	^ 'Person "Customer" {
	initial state "wants pizza"
		go to "order"
	
	activity "ordering pizza via phone" as "order"
		send "pizza description" to "Operator::accepting"
		go to "waiting"
	
	state "waiting"
		go to "accepts"
	
	activity "accepts pizza and pays" as "accepts"
		go to "complete"
	
	final state "purchase complete" as "complete"
}
System "Operator" {
	activity "processing order" as "accepting"
		go to "accept"
	
	state "order accepted" as "accept"
		go to "pass"
	
	activity "passes order" as "pass"
		send "order" to "Kitchen::accepts order"
		go to "final"
	
	final state "order processed" as "final"
}
Organization "Kitchen" {
	activity "accepts order"
		go to "cooking pizza"
	
	state "cooking pizza"
		go to "handover"
	
	activity "hands over pizza" as "handover"
		send "pizza" to "Delivery Boy::takes pizza"
		go to "final"
	
	final state "order completed" as "final"
}
Person "Delivery Boy" {
	activity "takes pizza"
		go to "driving to customer"
	
	state "driving to customer"
		go to "deliver"
	
	activity "delivers pizza" as "deliver"
		send "pizza" to "Customer::accepts" and receive "money"
		go to "back"
	
	state "driving back" as "back"
		go to "cash"
	
	activity "gives money to cashier" as "cash"
		send "money" to "Cashier::accepts money"
		go to "final"
	
	final state "delivery done" as "final"
}
Person "Cashier" {
	activity "accepts money"
}

' asNewBorm: 'Pizza Delivery'