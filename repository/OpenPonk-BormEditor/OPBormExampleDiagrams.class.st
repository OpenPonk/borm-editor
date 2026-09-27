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
