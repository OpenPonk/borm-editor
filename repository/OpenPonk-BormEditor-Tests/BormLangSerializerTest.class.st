"
Unit tests for textual BormLang serialization of BORM domain models, covering participant types, state qualifiers, transitions with constraints, inter-activity communications with data flows, and roundtrip parsing.
"
Class {
	#name : 'BormLangSerializerTest',
	#superclass : 'TestCase',
	#instVars : [
		'serializer'
	],
	#category : 'OpenPonk-BormEditor-Tests-Dsl',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Dsl'
}

{ #category : 'running' }
BormLangSerializerTest >> setUp [

	super setUp.
	serializer := BormLangSerializer new
]

{ #category : 'running' }
BormLangSerializerTest >> tearDown [

	serializer := nil.
	super tearDown
]

{ #category : 'tests' }
BormLangSerializerTest >> testClassExportDelegatesToInstanceExport [

	| model participant startState activity |
	model := BormORModel named: 'ClassExport'.
	participant := (BormParticipant named: 'User')
		               type: #Person;
		               yourself.
	startState := (BormState named: 'Start')
		              beInitial;
		              yourself.
	activity := BormActivity named: 'Work'.
	participant addAll: {
			startState.
			activity }.
	model add: participant.
	BormFactory transitionFrom: startState to: activity.

	self assert: (BormLangSerializer export: model) equals: (serializer export: model)
]

{ #category : 'tests' }
BormLangSerializerTest >> testExportAllStateQualifierVariants [

	| model participant plainState initialState finalState initialAndFinalState expectedText |
	model := BormORModel named: 'States'.
	participant := (BormParticipant named: 'Customer')
		               type: #Person;
		               yourself.
	plainState := BormState named: 'Plain'.
	initialState := (BormState named: 'Start')
		                beInitial;
		                yourself.
	finalState := (BormState named: 'Done')
		              beFinal;
		              yourself.
	initialAndFinalState := (BormState named: 'Single')
		                        beInitial;
		                        beFinal;
		                        yourself.
	participant addAll: {
			plainState.
			initialState.
			finalState.
			initialAndFinalState }.
	model add: participant.

	expectedText := 'Person "Customer" {
	state "Plain"

	initial state "Start"

	final state "Done"

	initial and final state "Single"
}'.
	self assert: (serializer export: model) equals: expectedText
]

{ #category : 'tests' }
BormLangSerializerTest >> testExportCommunicationsAndDataFlowCounts [

	| model customerParticipant operatorParticipant orderActivity confirmActivity processActivity doneState talkCommunication sendCommunication sendReceiveCommunication expectedText |
	model := BormORModel named: 'Communications'.
	customerParticipant := (BormParticipant named: 'Customer')
		                       type: #Person;
		                       yourself.
	orderActivity := BormActivity named: 'Order'.
	confirmActivity := BormActivity named: 'Confirm'.
	customerParticipant addAll: {
			orderActivity.
			confirmActivity }.

	operatorParticipant := (BormParticipant named: 'Operator')
		                       type: #System;
		                       yourself.
	processActivity := BormActivity named: 'Process'.
	doneState := (BormState named: 'Done')
		             beFinal;
		             yourself.
	operatorParticipant addAll: {
			processActivity.
			doneState }.

	model addAll: {
			customerParticipant.
			operatorParticipant }.

	talkCommunication := BormFactory communicationFrom: orderActivity to: processActivity.
	sendCommunication := BormFactory communicationFrom: orderActivity to: processActivity.
	sendCommunication addDataFlowNamed: 'request'.
	BormFactory transitionFrom: orderActivity to: confirmActivity.

	sendReceiveCommunication := BormFactory communicationFrom: processActivity to: confirmActivity.
	sendReceiveCommunication addDataFlowNamed: 'quote'.
	(sendReceiveCommunication addDataFlowNamed: 'confirmation') beOutput.
	BormFactory transitionFrom: processActivity to: doneState.

	expectedText := 'Person "Customer" {
	activity "Order"
		talk to "Operator::Process"
		send "request" to "Operator::Process"
		go to "Confirm"

	activity "Confirm"
}

System "Operator" {
	activity "Process"
		send "quote" to "Customer::Confirm" and receive "confirmation"
		go to "Done"

	final state "Done"
}'.
	self assert: (serializer export: model) equals: expectedText
]

{ #category : 'tests' }
BormLangSerializerTest >> testExportEmptyModel [

	self assert: (serializer export: BormORModel new) equals: ''.
	self assert: (serializer constraint: nil) equals: ''.
	self assert: (serializer newLineIf: false) equals: ''.
	self assert: (serializer newLineIf: true) equals: Character cr asString.
	self assert: (serializer name: 'Quoted') equals: '"Quoted"'
]

{ #category : 'tests' }
BormLangSerializerTest >> testExportParticipantTypesAndEmptyParticipants [

	| model personParticipant organizationParticipant systemParticipant expectedText |
	model := BormORModel named: 'Participants'.
	personParticipant := (BormParticipant named: 'Customer')
		                     type: #Person;
		                     yourself.
	organizationParticipant := (BormParticipant named: 'Warehouse')
		                           type: #Organization;
		                           yourself.
	systemParticipant := (BormParticipant named: 'Backend')
		                     type: #System;
		                     yourself.
	model addAll: {
			personParticipant.
			organizationParticipant.
			systemParticipant }.

	expectedText := 'Person "Customer" {

}

Organization "Warehouse" {

}

System "Backend" {

}'.
	self assert: (serializer export: model) equals: expectedText
]

{ #category : 'tests' }
BormLangSerializerTest >> testExportRoundtripMatchesParsedDomainStructure [

	| originalModel exportedText reparsedModel reparsedOrder reparsedProcess |
	originalModel := OPBormExamples examplePizzaDelivery.
	exportedText := serializer export: originalModel.
	reparsedModel := BormLangParser new parseStatements: exportedText.

	self assert: reparsedModel class identicalTo: BormORModel.
	self
		assertCollection: (reparsedModel participants collect: #name)
		hasSameElements: #( 'Customer' 'Operator' 'Kitchen' 'Delivery Boy' 'Cashier' ).
	reparsedOrder := reparsedModel @ 'Customer::ordering pizza via phone'.
	reparsedProcess := reparsedModel @ 'Operator::processing order'.
	self assert: reparsedOrder sent size equals: 1.
	self assert: reparsedOrder sent first receiver identicalTo: reparsedProcess.
	self assert: reparsedOrder sent first dataFlows first name equals: 'pizza description'
]

{ #category : 'tests' }
BormLangSerializerTest >> testExportTransitionsWithAndWithoutConstraints [

	| model participant startState decideActivity approvedState rejectedState guardedTransition fallbackTransition expectedText |
	model := BormORModel named: 'Transitions'.
	participant := (BormParticipant named: 'Applicant')
		               type: #Person;
		               yourself.
	startState := (BormState named: 'Start')
		              beInitial;
		              yourself.
	decideActivity := BormActivity named: 'Decide'.
	approvedState := (BormState named: 'Approved')
		                 beFinal;
		                 yourself.
	rejectedState := (BormState named: 'Rejected')
		                 beFinal;
		                 yourself.
	participant addAll: {
			startState.
			decideActivity.
			approvedState.
			rejectedState }.
	model add: participant.

	BormFactory transitionFrom: startState to: decideActivity.
	guardedTransition := BormFactory transitionFrom: decideActivity to: approvedState.
	guardedTransition constraint: (BormConstraint named: 'eligible').
	fallbackTransition := BormFactory transitionFrom: decideActivity to: rejectedState.
	self assert: fallbackTransition constraint identicalTo: nil.

	expectedText := 'Person "Applicant" {
	initial state "Start"
		go to "Decide"

	activity "Decide"
		go to "Approved" if "eligible"
		go to "Rejected"

	final state "Approved"

	final state "Rejected"
}'.
	self assert: (serializer export: model) equals: expectedText
]
