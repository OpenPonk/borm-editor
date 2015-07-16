samples
sampleTravelingCard
	^ 'Person "Customer" {
	initial state "wants a travel card"
		go to "request"

	activity "requests a new card" as "request"
		send "new card application" to "Vendor::processing application"
		go to "waiting"

	state "waiting for fulfilment" as "waiting"
		go to "processing errors"
		go to "pays"
	
	activity "processing errors"
		go to "errors resolved"
	
	state "errors resolved"
		go to "request"
	
	activity "pays"
		go to "waiting for card"
	
	state "waiting for card"
		go to "accepting card"
	
	activity "accepting card"
		go to "card bought"
	
	final state "card bought"
}
Person "Vendor" {
	activity "processing application"
		go to "decision"
	
	state "determining if order acceptable" as "decision"
		go to "deny"
		go to "confirm"
	
	activity "denying application" as "deny"
		send "reason of denial" to "Customer::processing errors"
		go to "final"
	
	activity "requests a payment" as "confirm"
		send "price" to "Customer::pays" and receive "payment"
		send "customer information" to "Card Distributor::processing data"
		go to "final"
	
	final state "order satisfied" as "final"
}
System "Card Distributor" {
	activity "processing data"
		go to "creating card"
	
	state "creating card"
		go to "delivery"
	
	activity "delivering card to the customer" as "delivery"
		send "card" to "Customer::accepting card"
		go to "final"
	
	final state "card delivered" as "final"
}' asBorm