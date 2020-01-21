Class {
	#name : #BormLangParserTest,
	#superclass : #BormLangGrammarTest,
	#category : 'Borm-Editor-Dsl'
}

{ #category : #accessing }
BormLangParserTest >> parserClass [
	^ BormLangParser
]

{ #category : #running }
BormLangParserTest >> setUp [
	super setUp.
	self parserInstance resetCache
]

{ #category : #tests }
BormLangParserTest >> testActivity [
	super testActivity.
	self assert: result name equals: 'name'
]

{ #category : #tests }
BormLangParserTest >> testCommunication [
	super testCommunication.
	self assert: result receiver equals: 'Org::a'.
	self assert: result dataFlows size equals: 0
]

{ #category : #tests }
BormLangParserTest >> testCommunication1 [
	super testCommunication1.
	self assert: result receiver equals: 'Org::a'.
	self assert: result dataFlows size equals: 1.
	self assert: result dataFlows first name equals: 'x'.
	self assert: result dataFlows first isInput
]

{ #category : #tests }
BormLangParserTest >> testCommunication2 [
	super testCommunication2.
	self assert: result receiver equals: 'Org::a'.
	self assert: result dataFlows size equals: 2.
	self assert: result dataFlows first name equals: 'x'.
	self assert: result dataFlows first isInput.
	self assert: result dataFlows second name equals: 'y'.
	self assert: result dataFlows second isOutput
]

{ #category : #tests }
BormLangParserTest >> testConstraint [
	super testConstraint.
	self assert: result equals: nil
]

{ #category : #tests }
BormLangParserTest >> testConstraint1 [
	super testConstraint1.
	self assert: result name equals: 'condition'
]

{ #category : #tests }
BormLangParserTest >> testDiagram [
	super testDiagram.

	self assert: result participants size equals: 2.
	self assert: (result @ 'Src::a') sent size equals: 1.
	self assert: (result @ 'Src::a') received size equals: 0.
	self assert: (result @ 'Dst::a') sent size equals: 0.
	self assert: (result @ 'Dst::a') received size equals: 1.
	
	self assert: (result @ 'Src::a') sent first sender equals: (result @ 'Src::a').
	self assert: (result @ 'Src::a') sent first receiver equals: (result @ 'Dst::a').
]

{ #category : #tests }
BormLangParserTest >> testDiagram2 [
	super testDiagram2.

	self assert: result participants size equals: 2.
	self assert: (result @ 'Src::a') sent size equals: 1.
	self assert: (result @ 'Src::a') received size equals: 1.
	self assert: (result @ 'Dst::a') sent size equals: 1.
	self assert: (result @ 'Dst::a') received size equals: 1.

	self assert: (result @ 'Src::a') sent first sender equals: result @ 'Src::a'.
	self assert: (result @ 'Src::a') sent first receiver equals: result @ 'Dst::a'.
	self assert: (result @ 'Src::a') sent first dataFlows size equals: 0.

	self assert: (result @ 'Src::a') received first sender equals: result @ 'Dst::a'.
	self assert: (result @ 'Src::a') received first receiver equals: result @ 'Src::a'.
	self assert: (result @ 'Src::a') received first dataFlows size equals: 2
]

{ #category : #tests }
BormLangParserTest >> testNode [
	super testNode.
	self assert: result outgoing size equals: 0
]

{ #category : #tests }
BormLangParserTest >> testNode1 [
	super testNode1.
	self assert: result outgoing size equals: 1.
	self assert: result outgoing first source equals: result
]

{ #category : #tests }
BormLangParserTest >> testNode2 [
	super testNode2.
	self assert: result outgoing size equals: 2.
	result outgoing do: [ :each | self assert: each source equals: result ]
]

{ #category : #tests }
BormLangParserTest >> testParticipant [
	super testParticipant.
	self assert: result type equals: BormParticipantType Person.
	self assert: result name equals: 'Customer'.
	self assert: result nodes size equals: 0
]

{ #category : #tests }
BormLangParserTest >> testParticipant1 [
	super testParticipant1.
	self assert: result type equals: BormParticipantType System.
	self assert: result name equals: 'Sys'.
	self assert: result nodes size equals: 1
]

{ #category : #tests }
BormLangParserTest >> testParticipant2 [
	super testParticipant2.
	self assert: result type equals: BormParticipantType Organization.
	self assert: result name equals: 'Org'.
	self assert: result nodes size equals: 2
]

{ #category : #tests }
BormLangParserTest >> testParticipant3 [
	super testParticipant3.
	self assert: result nodes size equals: 2.
	self assert: result nodes first outgoing first target equals: result nodes second
]

{ #category : #tests }
BormLangParserTest >> testParticipantType [
	super testParticipantType.
	self assert: result equals: BormParticipantType Person
]

{ #category : #tests }
BormLangParserTest >> testParticipantType1 [
	super testParticipantType1.
	self assert: result equals: BormParticipantType Organization
]

{ #category : #tests }
BormLangParserTest >> testParticipants [
	super testParticipants.
	self assert: result isEmpty
]

{ #category : #tests }
BormLangParserTest >> testParticipants1 [
	super testParticipants1.
	self assert: result size equals: 1.
	self assert: result first name equals: 'Sys'.
	self assert: result first nodes size equals: 1
]

{ #category : #tests }
BormLangParserTest >> testParticipants2 [
	super testParticipants2.
	self assert: result size equals: 2.
	self assert: result first name equals: 'Sys'.
	self assert: result first nodes size equals: 1.
	self assert: result second name equals: 'Org'.
	self assert: result second nodes size equals: 1
]

{ #category : #tests }
BormLangParserTest >> testParticipants3 [
	super testParticipants3.
	self assert: result size equals: 2.
	self assert: result first nodes size equals: 2.
	self assert: result first nodes first outgoing first target equals: result first nodes second.
	self assert: result second nodes size equals: 2.
	self assert: result second nodes first outgoing first target equals: result second nodes second
]

{ #category : #tests }
BormLangParserTest >> testState [
	super testState.
	self assert: result name equals: 'hello'.
	self deny: result isInitial.
	self deny: result isFinal
]

{ #category : #tests }
BormLangParserTest >> testState1 [
	super testState1.
	self assert: result name equals: 'hello'.
	self assert: result isInitial.
	self deny: result isFinal
]

{ #category : #tests }
BormLangParserTest >> testState2 [
	super testState2.
	self assert: result name equals: 'hello'.
	self deny: result isInitial.
	self assert: result isFinal
]

{ #category : #tests }
BormLangParserTest >> testState3 [
	super testState3.
	self assert: result name equals: 'hello'.
	self assert: result isInitial.
	self assert: result isFinal
]

{ #category : #tests }
BormLangParserTest >> testTransition [
	super testTransition.
	self assert: result target equals: 'vertex'
]

{ #category : #tests }
BormLangParserTest >> testTransition1 [
	super testTransition1.
	self assert: result target equals: 'vertex'.
	self assert: result constraint name equals: 'condition'
]
