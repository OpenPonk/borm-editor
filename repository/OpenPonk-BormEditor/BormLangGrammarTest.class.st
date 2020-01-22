Class {
	#name : #BormLangGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #'OpenPonk-BormEditor-Dsl'
}

{ #category : #accessing }
BormLangGrammarTest >> parserClass [
	^ BormLangGrammar
]

{ #category : #tests }
BormLangGrammarTest >> testActivity [
	self parse: 'activity "name"' rule: #activity
]

{ #category : #tests }
BormLangGrammarTest >> testCommunication [
	self parse: 'talk to "Org::a"' rule: #communication
]

{ #category : #tests }
BormLangGrammarTest >> testCommunication1 [
	self parse: 'send "x" to "Org::a"' rule: #communication
]

{ #category : #tests }
BormLangGrammarTest >> testCommunication2 [
	self parse: 'send "x" to "Org::a" and receive "y"' rule: #communication
]

{ #category : #tests }
BormLangGrammarTest >> testConstraint [
	self parse: '' rule: #constraint
]

{ #category : #tests }
BormLangGrammarTest >> testConstraint1 [
	self parse: ' if "condition"' rule: #constraint
]

{ #category : #tests }
BormLangGrammarTest >> testDiagram [
	self
		parse:
			'System "Src" {
	activity "a"
		talk to "Dst::a"
}
Organization "Dst" {
	activity "a"
}'
		rule: #diagram
]

{ #category : #tests }
BormLangGrammarTest >> testDiagram2 [
	self
		parse:
			'System "Src" {
	activity "a"
		talk to "Dst::a"
}
Organization "Dst" {
	activity "a"
		send "x" to "Src::a" and receive "y"
}'
		rule: #diagram
]

{ #category : #tests }
BormLangGrammarTest >> testNode [
	self parse: 'state "hello"' rule: #node
]

{ #category : #tests }
BormLangGrammarTest >> testNode1 [
	self
		parse:
			'state "hello"
	go to "x"'
		rule: #node
]

{ #category : #tests }
BormLangGrammarTest >> testNode2 [
	self
		parse:
			'state "hello"
	go to "x"
	go to "y"'
		rule: #node
]

{ #category : #tests }
BormLangGrammarTest >> testParticipant [
	self
		parse:
			'Person "Customer" {
}'
		rule: #participant
]

{ #category : #tests }
BormLangGrammarTest >> testParticipant1 [
	self parse: 'System "Sys" {
	state "x"
}' rule: #participant
]

{ #category : #tests }
BormLangGrammarTest >> testParticipant2 [
	self parse: 'Organization "Org" {
	state "x"
	activity "y"
}' rule: #participant
]

{ #category : #tests }
BormLangGrammarTest >> testParticipant3 [
	self
		parse:
			'Organization "Org" {
	state "x x" as "x"
		go to "y"
	activity "y y" as "y"
}'
		rule: #participant
]

{ #category : #tests }
BormLangGrammarTest >> testParticipantType [
	self parse: 'Person' rule: #participantType
]

{ #category : #tests }
BormLangGrammarTest >> testParticipantType1 [
	self parse: 'Organization' rule: #participantType
]

{ #category : #tests }
BormLangGrammarTest >> testParticipantType2 [
	self fail: 'Whatever' rule: #participantType
]

{ #category : #tests }
BormLangGrammarTest >> testParticipants [
	self parse: '' rule: #participants
]

{ #category : #tests }
BormLangGrammarTest >> testParticipants1 [
	self
		parse:
			'System "Sys" {
	state "x"
}'
		rule: #participants
]

{ #category : #tests }
BormLangGrammarTest >> testParticipants2 [
	self
		parse:
			'System "Sys" {
	activity "x"
}
Organization "Org" {
	activity "x"
}'
		rule: #participants
]

{ #category : #tests }
BormLangGrammarTest >> testParticipants3 [
	self
		parse:
			'System "Sys" {
	activity "a1"
		go to "s1"
	state "s1"
}
Organization "Org" {
	activity "a2"
		go to "s2"
	state "s2"
}'
		rule: #participants
]

{ #category : #tests }
BormLangGrammarTest >> testQuotedString [
	self parse: '"quoted string"' rule: #name.
	self assert: result equals: 'quoted string'.
	self fail: '''quoted string''' rule: #name.
	self fail: '""' rule: #name
]

{ #category : #tests }
BormLangGrammarTest >> testState [
	self parse: 'state "hello"' rule: #state
]

{ #category : #tests }
BormLangGrammarTest >> testState1 [
	self parse: 'initial state "hello"' rule: #state
]

{ #category : #tests }
BormLangGrammarTest >> testState2 [
	self parse: 'final state "hello"' rule: #state
]

{ #category : #tests }
BormLangGrammarTest >> testState3 [
	self parse: 'initial and final state "hello"' rule: #state
]

{ #category : #tests }
BormLangGrammarTest >> testStateType [
	self parse: 'initial' rule: #stateType.
	self assert: result equals: 'initial'.
	
	self parse: 'final' rule: #stateType.
	self assert: result equals: 'final'.

	self fail: 'nothing' rule: #stateType
]

{ #category : #tests }
BormLangGrammarTest >> testString [
	self parse: 'some string' rule: #string.
	self assert: result equals: 'some string'.
	self fail: '' rule: #string
]

{ #category : #tests }
BormLangGrammarTest >> testTransition [
	self parse: 'go to "vertex"' rule: #transition
]

{ #category : #tests }
BormLangGrammarTest >> testTransition1 [
	self parse: 'go to "vertex" if "condition"' rule: #transition
]

{ #category : #tests }
BormLangGrammarTest >> testTransitions [
	self parse: '' rule: #transitions.
	self assert: result equals: #().

	self parse: 'go to "activity"' rule: #transitions.
	self assert: result equals: #(#('activity' nil)).

	self parse: 'go to "activity" if "x" go to "state" if "y"' rule: #transitions.
	self assert: result equals: #(#('activity' 'x') #('state' 'y'))
]
