"
I provide a collection of executable example diagrams (e.g., Pizza Delivery, Traveling Card) demonstrating BORM models within the OpenPonk editor.
"
Class {
	#name : 'OPBormExampleDiagrams',
	#superclass : 'Object',
	#category : 'OpenPonk-BormEditor-Examples',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Examples'
}

{ #category : 'samples' }
OPBormExampleDiagrams class >> emptyModel [

	<script: 'self emptyModel inspect'>
	^ BormORModel named: 'ORD'
]

{ #category : 'samples' }
OPBormExampleDiagrams class >> exampleDataFlows [

	<script: 'self exampleDataFlows inspect'>
	| diagram user sys |
	diagram := BormORModel named: 'Two Participants'.
	user := BormParticipant named: 'User'.
	(sys := BormParticipant named: 'System') type:
		BormParticipantType System.

	diagram addAll: {
			user.
			sys }.

	user addAll: {
			(BormState named: 'init') beInitial.
			(BormActivity named: 'a1').
			(BormState named: 'sMid').
			(BormActivity named: 'a2').
			(BormState named: 's2') beFinal }.

	user @ 'init' -> (user @ 'a1').
	user @ 'a1' -> (user @ 'sMid').
	user @ 'sMid' -> (user @ 'a2').
	user @ 'a2' -> (user @ 's2').

	sys addAll: {
			(BormState named: 's1') beInitial.
			(BormActivity named: 'a1').
			(BormState named: 'sMid').
			(BormActivity named: 'a2').
			(BormState named: 's2') beFinal }.

	BormFactory
		addFqnTransitions: {
				('s1' -> 'a1').
				('a1' -> 'sMid').
				('sMid' -> 'a2').
				('a2' -> 's2') }
		in: sys.


	user @ 'a1' ==> (sys @ 'a1') addDataFlowNamed: 'input'.

	diagram @ 'System::a2' ==> (diagram @ 'User::a2') addDataFlow:
		(BormDataFlow named: 'output') beOutput.

	^ diagram
]

{ #category : 'examples' }
OPBormExampleDiagrams class >> exampleLoanApproval [
	<script: 'self exampleLoanApproval inspect'>
	^ 'Person "Applicant" {
	initial state "wants a loan"
		go to "submit application"

	activity "submitting application" as "submit application"
		send "loan application" to "Loan Officer::evaluates"
		go to "waiting for decision"

	state "waiting for decision"
		go to "receives contract" if "approved"
		go to "receives rejection" if "rejected"

	activity "signs loan contract" as "receives contract"
		go to "loan active"

	activity "reviews rejection reason" as "receives rejection"
		go to "loan rejected"

	final state "loan active"
	final state "loan rejected"
}
Person "Loan Officer" {
	activity "evaluating loan application" as "evaluates"
		go to "decision"

	state "credit score evaluated" as "decision"
		go to "approve"
		go to "reject"

	activity "approves loan" as "approve"
		send "approval notification" to "Applicant::receives contract"
		go to "final"

	activity "rejects loan" as "reject"
		send "rejection letter" to "Applicant::receives rejection"
		go to "final"

	final state "evaluation complete" as "final"
}' asBorm: 'Loan Approval'
]

{ #category : 'samples' }
OPBormExampleDiagrams class >> examplePizzaDelivery [

	<script: 'self examplePizzaDelivery inspect'>
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

' asBorm: 'Pizza Delivery'
]

{ #category : 'samples' }
OPBormExampleDiagrams class >> exampleTravelingCard [

	<script: 'self exampleTravelingCard inspect'>
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
}' asBorm: 'Traveling Card'
]

{ #category : 'examples' }
OPBormExampleDiagrams class >> openExampleDataFlows [
	<example>
	self exampleDataFlows openAs: 'Example Data Flows'
]

{ #category : 'examples' }
OPBormExampleDiagrams class >> openExampleEmptyModel [
	<example>
	^ self emptyModel openAs: 'BORM'
]

{ #category : 'examples' }
OPBormExampleDiagrams class >> openExamplePizzaDelivery [
	<example>
	^ self examplePizzaDelivery openAs: 'Pizza Delivery'
]

{ #category : 'examples' }
OPBormExampleDiagrams class >> openExampleTravelingCard [
	<example>
	^ self exampleTravelingCard openAs: 'Traveling Card'
]
