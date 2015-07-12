strings
participant
	^ 'Person "Customer" {
	initial state "wants pizza"
		go to "order"
	
	activity "order"
		send "pizza choice" to "Operator::accepts order"
		go to "wait"
	
	state "wait for pizza" as "wait"
		go to "pay"
	
	activity "accepts pizza and pays" as "pay"
		go to "final"
	
	final state "purchase completed" as "final"
}'