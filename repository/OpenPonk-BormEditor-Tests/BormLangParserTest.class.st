"
I am a unit test class verifying that the BormLang parser correctly maps textual DSL syntax strings into fully instantiated BORM semantic model objects.
"
Class {
	#name : 'BormLangParserTest',
	#superclass : 'BormLangGrammarTest',
	#category : 'OpenPonk-BormEditor-Tests-Dsl',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Dsl'
}

{ #category : 'accessing' }
BormLangParserTest >> parserClass [
	^ BormLangParser
]

{ #category : 'running' }
BormLangParserTest >> setUp [
	super setUp.
	self parserInstance resetCache
]

{ #category : 'tests' }
BormLangParserTest >> testActivity [
	super testActivity.
	self assert: result name equals: 'name'
]

{ #category : 'tests' }
BormLangParserTest >> testCommunication [

	super testCommunication.
	self assert: result receiver equals: 'Org::a'.
	self assertEmpty: result dataFlows
]

{ #category : 'tests' }
BormLangParserTest >> testCommunication1 [

	super testCommunication1.
	self assert: result receiver equals: 'Org::a'.
	self assert: result dataFlows size equals: 1.
	self assert: result dataFlows first name equals: 'x'.
	self assert: result dataFlows first type equals: BormDataFlow inputType
]

{ #category : 'tests' }
BormLangParserTest >> testCommunication2 [

	super testCommunication2.
	self assert: result receiver equals: 'Org::a'.
	self assert: result dataFlows size equals: 2.
	self assert: result dataFlows first name equals: 'x'.
	self assert: result dataFlows first type equals: BormDataFlow inputType.
	self assert: result dataFlows second name equals: 'y'.
	self assert: result dataFlows second type equals: BormDataFlow outputType
]

{ #category : 'tests' }
BormLangParserTest >> testConstraint [

	super testConstraint.
	self assert: result identicalTo: nil
]

{ #category : 'tests' }
BormLangParserTest >> testConstraint1 [
	super testConstraint1.
	self assert: result name equals: 'condition'
]

{ #category : 'tests' }
BormLangParserTest >> testDiagram [

	super testDiagram.

	self assert: result participants size equals: 2.
	self assert: (result @ 'Src::a') sent size equals: 1.
	self assertEmpty: (result @ 'Src::a') received.
	self assertEmpty: (result @ 'Dst::a') sent.
	self assert: (result @ 'Dst::a') received size equals: 1.

	self assert: (result @ 'Src::a') sent first sender identicalTo: result @ 'Src::a'.
	self assert: (result @ 'Src::a') sent first receiver identicalTo: result @ 'Dst::a'
]

{ #category : 'tests' }
BormLangParserTest >> testDiagram2 [

	super testDiagram2.

	self assert: result participants size equals: 2.
	self assert: (result @ 'Src::a') sent size equals: 1.
	self assert: (result @ 'Src::a') received size equals: 1.
	self assert: (result @ 'Dst::a') sent size equals: 1.
	self assert: (result @ 'Dst::a') received size equals: 1.

	self assert: (result @ 'Src::a') sent first sender identicalTo: result @ 'Src::a'.
	self assert: (result @ 'Src::a') sent first receiver identicalTo: result @ 'Dst::a'.
	self assertEmpty: (result @ 'Src::a') sent first dataFlows.

	self assert: (result @ 'Src::a') received first sender identicalTo: result @ 'Dst::a'.
	self assert: (result @ 'Src::a') received first receiver identicalTo: result @ 'Src::a'.
	self assert: (result @ 'Src::a') received first dataFlows size equals: 2
]

{ #category : 'tests' }
BormLangParserTest >> testNode [

	super testNode.
	self assertEmpty: result outgoing
]

{ #category : 'tests' }
BormLangParserTest >> testNode1 [
	super testNode1.
	self assert: result outgoing size equals: 1.
	self assert: result outgoing first source equals: result
]

{ #category : 'tests' }
BormLangParserTest >> testNode2 [
	super testNode2.
	self assert: result outgoing size equals: 2.
	result outgoing do: [ :each | self assert: each source equals: result ]
]

{ #category : 'tests' }
BormLangParserTest >> testParseDirectRepeatedCallsOnSameInstanceResetCache [

	| bormParser firstModel secondModel |
	bormParser := BormLangParser new.
	firstModel := bormParser parse: 'Person "Src" {
	activity "Send"
		talk to "Dst::receive"
}

System "Dst" {
	activity "Receive" as "receive"
}'.
	self assert: (firstModel @ 'Src::Send') sent first receiver identicalTo: firstModel @ 'Dst::Receive'.

	secondModel := bormParser parse: 'Organization "Client" {
	activity "Request"
		send "payload" to "Server::handle"
}

System "Server" {
	activity "Handle" as "handle"
}'.
	self assert: (secondModel participants collect: #name as: Array) equals: #( 'Client' 'Server' ).
	self assert: (secondModel @ 'Client::Request') sent first receiver identicalTo: secondModel @ 'Server::Handle'
]

{ #category : 'tests' }
BormLangParserTest >> testParseStatementsAfterSyntaxFailureAndKeyNotFoundResetsCache [

	| bormParser failure recoveredFromSyntaxFailure recoveredFromKeyNotFound |
	bormParser := BormLangParser new.
	failure := bormParser parseStatements: 'Person "Broken" {
	activity "Order"
		talk to "Missing::target"
		go to "Later"
	invalidStatement
}'.
	self assert: failure isPetitFailure description: 'Incomplete participant syntax must fail parsing'.

	recoveredFromSyntaxFailure := bormParser parseStatements: 'Organization "Clean" {
	activity "Work"
}'.
	self assert: (recoveredFromSyntaxFailure participants collect: #name as: Array) equals: #( 'Clean' ).
	self assertEmpty: (recoveredFromSyntaxFailure @ 'Clean::Work') outgoing.
	self assertEmpty: (recoveredFromSyntaxFailure @ 'Clean::Work') sent.

	self
		should: [
				bormParser parseStatements: 'Person "Broken" {
	activity "Order"
		talk to "Missing::target"
}' ]
		raise: KeyNotFound.

	recoveredFromKeyNotFound := bormParser parseStatements: 'System "Recovered" {
	state "Ready"
}'.
	self assert: (recoveredFromKeyNotFound participants collect: #name as: Array) equals: #( 'Recovered' ).
	self assert: (recoveredFromKeyNotFound @ 'Recovered::Ready') name equals: 'Ready'
]

{ #category : 'tests' }
BormLangParserTest >> testParseStatementsEmptyInput [

	| parsedModel |
	parsedModel := BormLangParser new parseStatements: ''.
	self assert: parsedModel class identicalTo: BormORModel.
	self assertEmpty: parsedModel participants
]

{ #category : 'tests' }
BormLangParserTest >> testParseStatementsInvalidSyntaxReturnsFailure [

	| failure |
	failure := BormLangParser new parseStatements: 'Person "Customer" {
	unknownStatement
}'.
	self assert: failure isPetitFailure description: 'Invalid BormLang syntax must return a PetitParser failure'.
	self assert: failure position > 0 description: 'Failure position must advance past the valid prefix'
]

{ #category : 'tests' }
BormLangParserTest >> testParseStatementsMissingCommunicationTargetSignalsKeyNotFound [

	self
		should: [
				BormLangParser new parseStatements: 'Person "Customer" {
	activity "Order"
		talk to "Missing::target"
}' ]
		raise: KeyNotFound
]

{ #category : 'tests' }
BormLangParserTest >> testParseStatementsRepeatedCallsOnSameInstanceResetCache [

	| bormParser firstModel emptyModel soloModel |
	bormParser := BormLangParser new.
	firstModel := bormParser parseStatements: 'Person "Customer" {
	activity "Order" as "order"
		talk to "Operator::accept"
}

System "Operator" {
	activity "Accept" as "accept"
		send "receipt" to "Customer::order" and receive "ack"
}'.
	self assert: (firstModel participants collect: #name as: Array) equals: #( 'Customer' 'Operator' ).
	self assert: (firstModel @ 'Customer::Order') sent first receiver identicalTo: firstModel @ 'Operator::Accept'.
	self assert: (firstModel @ 'Operator::Accept') sent first receiver identicalTo: firstModel @ 'Customer::Order'.

	emptyModel := bormParser parseStatements: ''.
	self assert: emptyModel class identicalTo: BormORModel.
	self assertEmpty: emptyModel participants.

	soloModel := bormParser parseStatements: 'Organization "Solo" {
	activity "Work"
}'.
	self assert: (soloModel participants collect: #name as: Array) equals: #( 'Solo' ).
	self assertEmpty: (soloModel @ 'Solo::Work') sent.
	self assertEmpty: (soloModel @ 'Solo::Work') received.

	self
		should: [
				bormParser parseStatements: 'Person "Customer" {
	activity "Order"
		talk to "Operator::accept"
}' ]
		raise: KeyNotFound
]

{ #category : 'tests' }
BormLangParserTest >> testParseStatementsValidMultiParticipantModel [

	| parsedModel customerParticipant operatorParticipant startState orderActivity doneState acceptActivity |
	parsedModel := BormLangParser new parseStatements: 'Person "Customer" {
	initial state "Start"
		go to "order" if "hungry"

	activity "Order" as "order"
		talk to "Operator::accept"
		go to "Done"

	final state "Done"
}

System "Operator" {
	activity "Accept" as "accept"
		send "bill" to "Customer::order" and receive "payment"
}'.

	self assert: parsedModel class identicalTo: BormORModel.
	self assert: (parsedModel participants collect: #name as: Array) equals: #( 'Customer' 'Operator' ).
	customerParticipant := parsedModel @ 'Customer'.
	operatorParticipant := parsedModel @ 'Operator'.
	self assert: customerParticipant type equals: #Person.
	self assert: operatorParticipant type equals: #System.

	startState := parsedModel @ 'Customer::Start'.
	orderActivity := parsedModel @ 'Customer::Order'.
	doneState := parsedModel @ 'Customer::Done'.
	acceptActivity := parsedModel @ 'Operator::Accept'.
	self assert: startState isInitial description: 'Start state must be marked initial'.
	self assert: doneState isFinal description: 'Done state must be marked final'.
	self assert: startState outgoing first target identicalTo: orderActivity.
	self assert: startState outgoing first constraint name equals: 'hungry'.
	self assert: orderActivity sent first receiver identicalTo: acceptActivity.
	self assertEmpty: orderActivity sent first dataFlows.
	self assert: acceptActivity sent first receiver identicalTo: orderActivity.
	self assert: acceptActivity sent first dataFlows size equals: 2.
	self assert: acceptActivity sent first dataFlows first type equals: BormDataFlow inputType.
	self assert: acceptActivity sent first dataFlows second type equals: BormDataFlow outputType
]

{ #category : 'tests' }
BormLangParserTest >> testParticipant [

	super testParticipant.
	self assert: result type equals: BormParticipantType Person.
	self assert: result name equals: 'Customer'.
	self assertEmpty: result nodes
]

{ #category : 'tests' }
BormLangParserTest >> testParticipant1 [
	super testParticipant1.
	self assert: result type equals: BormParticipantType System.
	self assert: result name equals: 'Sys'.
	self assert: result nodes size equals: 1
]

{ #category : 'tests' }
BormLangParserTest >> testParticipant2 [
	super testParticipant2.
	self assert: result type equals: BormParticipantType Organization.
	self assert: result name equals: 'Org'.
	self assert: result nodes size equals: 2
]

{ #category : 'tests' }
BormLangParserTest >> testParticipant3 [

	super testParticipant3.
	self assert: result nodes size equals: 2.
	self assert: result nodes first outgoing first target identicalTo: result nodes second
]

{ #category : 'tests' }
BormLangParserTest >> testParticipantType [
	super testParticipantType.
	self assert: result equals: BormParticipantType Person
]

{ #category : 'tests' }
BormLangParserTest >> testParticipantType1 [
	super testParticipantType1.
	self assert: result equals: BormParticipantType Organization
]

{ #category : 'tests' }
BormLangParserTest >> testParticipants [

	super testParticipants.
	self assertEmpty: result
]

{ #category : 'tests' }
BormLangParserTest >> testParticipants1 [
	super testParticipants1.
	self assert: result size equals: 1.
	self assert: result first name equals: 'Sys'.
	self assert: result first nodes size equals: 1
]

{ #category : 'tests' }
BormLangParserTest >> testParticipants2 [
	super testParticipants2.
	self assert: result size equals: 2.
	self assert: result first name equals: 'Sys'.
	self assert: result first nodes size equals: 1.
	self assert: result second name equals: 'Org'.
	self assert: result second nodes size equals: 1
]

{ #category : 'tests' }
BormLangParserTest >> testParticipants3 [
	super testParticipants3.
	self assert: result size equals: 2.
	self assert: result first nodes size equals: 2.
	self assert: result first nodes first outgoing first target equals: result first nodes second.
	self assert: result second nodes size equals: 2.
	self assert: result second nodes first outgoing first target equals: result second nodes second
]

{ #category : 'tests' }
BormLangParserTest >> testReplaceModelWithEmptyStatementsClearsElements [

	| targetModel emptyParsedModel |
	targetModel := BormORModel named: 'Cleared Model'.
	targetModel add: (BormParticipant named: 'Temporary').
	emptyParsedModel := BormLangParser new parseStatements: ''.

	self parserInstance replaceModel: targetModel withStatements: emptyParsedModel.

	self assert: targetModel name equals: 'Cleared Model'.
	self assertEmpty: targetModel elements
]

{ #category : 'tests' }
BormLangParserTest >> testReplaceModelWithStatementsReplacesElementsPreservingModelIdentityAndName [

	| targetModel oldParticipant parsedModel newParticipants |
	targetModel := BormORModel named: 'Existing Model'.
	oldParticipant := BormParticipant named: 'Legacy'.
	targetModel add: oldParticipant.
	parsedModel := BormLangParser new parseStatements: 'Organization "Shop" {
	activity "Process" as "process"
		send "order" to "Warehouse::fulfill"
}

System "Warehouse" {
	activity "Fulfill" as "fulfill"
}'.

	self parserInstance replaceModel: targetModel withStatements: parsedModel.

	self assert: targetModel name equals: 'Existing Model'.
	newParticipants := targetModel participants.
	self assert: newParticipants size equals: 2.
	self assert: (newParticipants collect: #name as: Array) equals: #( 'Shop' 'Warehouse' ).
	self denyCollection: newParticipants includesAny: { oldParticipant }.
	newParticipants do: [ :each | self assert: each owner identicalTo: targetModel ].
	self assert: (targetModel @ 'Shop::Process') sent first receiver identicalTo: targetModel @ 'Warehouse::Fulfill'
]

{ #category : 'tests' }
BormLangParserTest >> testState [

	super testState.
	self assert: result name equals: 'hello'.
	self deny: result isInitial description: 'Regular state must not be initial'.
	self deny: result isFinal description: 'Regular state must not be final'
]

{ #category : 'tests' }
BormLangParserTest >> testState1 [

	super testState1.
	self assert: result name equals: 'hello'.
	self assert: result isInitial description: 'Initial state must be marked initial'.
	self deny: result isFinal description: 'Initial state must not be final'
]

{ #category : 'tests' }
BormLangParserTest >> testState2 [

	super testState2.
	self assert: result name equals: 'hello'.
	self deny: result isInitial description: 'Final state must not be initial'.
	self assert: result isFinal description: 'Final state must be marked final'
]

{ #category : 'tests' }
BormLangParserTest >> testState3 [

	super testState3.
	self assert: result name equals: 'hello'.
	self assert: result isInitial description: 'Initial and final state must be marked initial'.
	self assert: result isFinal description: 'Initial and final state must be marked final'
]

{ #category : 'tests' }
BormLangParserTest >> testTransition [
	super testTransition.
	self assert: result target equals: 'vertex'
]

{ #category : 'tests' }
BormLangParserTest >> testTransition1 [
	super testTransition1.
	self assert: result target equals: 'vertex'.
	self assert: result constraint name equals: 'condition'
]
