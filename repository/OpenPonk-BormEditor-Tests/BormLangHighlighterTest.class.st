"
Unit tests for BormLang textual DSL syntax highlighting rules, verifying PPToken-to-Color associations across participant types, state qualifiers, activities, quoted identifiers, full diagrams, and invalid inputs.
"
Class {
	#name : 'BormLangHighlighterTest',
	#superclass : 'PPCompositeParserTest',
	#category : 'OpenPonk-BormEditor-Tests-Dsl',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Dsl'
}

{ #category : 'helpers' }
BormLangHighlighterTest >> colorAssociationsFrom: parsedTokens [

	| extracted |
	extracted := OrderedCollection new.
	parsedTokens flattened select: [ :each | each isKindOf: Association ] thenDo: [ :each |
			((each key isKindOf: Association) and: [ each value isKindOf: Association ])
				ifTrue: [
						extracted add: each key key inputValue -> each key value.
						extracted add: each value key inputValue -> each value value ]
				ifFalse: [ extracted add: each key inputValue -> each value ] ].
	^ extracted
]

{ #category : 'accessing' }
BormLangHighlighterTest >> parserClass [

	^ BormLangHighlighter
]

{ #category : 'tests' }
BormLangHighlighterTest >> testHighlightActivityStartAndActivity [

	| nameColor |
	nameColor := Color green muchDarker darker.
	self parse: 'activity' rule: #activityStart.
	self assert: result key inputValue equals: 'activity'.
	self assert: result value equals: Color purple.

	self parse: 'activity "Process Order"' rule: #activity.
	self assert: result first key inputValue equals: 'activity'.
	self assert: result first value equals: Color purple.
	self assert: result third key key inputValue equals: '"Process Order"'.
	self assert: result third key value equals: nameColor.

	self parse: 'activity "Process Order" as "process"' rule: #activity.
	self assert: result third key key inputValue equals: '"Process Order"'.
	self assert: result third value key inputValue equals: '"process"'.
	self assert: result third value value equals: nameColor
]

{ #category : 'tests' }
BormLangHighlighterTest >> testHighlightFullDiagramAndInvalidInput [

	| diagramSource tokenColors nameColor directResult directFailure |
	nameColor := Color green muchDarker darker.
	diagramSource := 'Person "Customer" {
	initial state "Start"
		go to "req" if "ready"

	activity "Request" as "req"
		send "pizza" to "Operator::Accept"
		go to "Done"

	final state "Done"
}

System "Operator" {
	activity "Accept"
}'.
	self parse: diagramSource.
	tokenColors := self colorAssociationsFrom: result.
	self assertCollection: tokenColors includesAll: {
			('Person' -> Color blue).
			('System' -> Color blue).
			('initial' -> Color purple).
			('state' -> Color purple).
			('final' -> Color purple).
			('activity' -> Color purple).
			('"Customer"' -> nameColor).
			('"Request"' -> nameColor).
			('"req"' -> nameColor).
			('"Operator"' -> nameColor).
			('"Accept"' -> nameColor).
			('"pizza"' -> nameColor).
			('"Operator::Accept"' -> nameColor) }.

	directResult := BormLangHighlighter new parse: diagramSource.
	self deny: directResult isPetitFailure description: 'Fresh highlighter instance must parse valid BormLang diagram'.
	self assert: (self colorAssociationsFrom: directResult) asArray equals: tokenColors asArray.

	self fail: 'UnknownType "Broken" {}' rule: #start.
	self assert: result position equals: 0.
	directFailure := BormLangHighlighter new parse: 'UnknownType "Broken" {}'.
	self assert: directFailure isPetitFailure description: 'Fresh highlighter instance must fail on unknown participant type'.
	self assert: directFailure position equals: 0
]

{ #category : 'tests' }
BormLangHighlighterTest >> testHighlightNameAndNamePair [

	| expectedColor |
	expectedColor := Color green muchDarker darker.
	self parse: '"Customer Name"' rule: #name.
	self assert: result key class identicalTo: PPToken.
	self assert: result key inputValue equals: '"Customer Name"'.
	self assert: result value equals: expectedColor.

	self parse: '"Order pizza" as "order"' rule: #namePair.
	self assert: result key key inputValue equals: '"Order pizza"'.
	self assert: result key value equals: expectedColor.
	self assert: result value key inputValue equals: '"order"'.
	self assert: result value value equals: expectedColor.

	self fail: '""' rule: #name
]

{ #category : 'tests' }
BormLangHighlighterTest >> testHighlightParticipantTypes [

	#( 'Person' 'Organization' 'System' ) do: [ :typeName |
			self parse: typeName rule: #participantType.
			self assert: result key class identicalTo: PPToken.
			self assert: result key inputValue equals: typeName.
			self assert: result value equals: Color blue ].

	self fail: 'Robot' rule: #participantType
]

{ #category : 'tests' }
BormLangHighlighterTest >> testHighlightStateTypeAndStateVariants [

	| nameColor |
	nameColor := Color green muchDarker darker.
	#( 'initial' 'final' 'initial and final' ) do: [ :qualifier |
			self parse: qualifier rule: #stateType.
			self assert: result key inputValue equals: qualifier.
			self assert: result value equals: Color purple ].

	self parse: 'state "Waiting"' rule: #state.
	self assert: result first identicalTo: nil.
	self assert: result second key inputValue equals: 'state'.
	self assert: result second value equals: Color purple.
	self assert: result third key key inputValue equals: '"Waiting"'.
	self assert: result third key value equals: nameColor.

	self parse: 'initial state "Start"' rule: #state.
	self assert: result first first key inputValue equals: 'initial'.
	self assert: result first first value equals: Color purple.
	self assert: result second key inputValue equals: 'state'.
	self assert: result second value equals: Color purple.

	self parse: 'final state "Done"' rule: #state.
	self assert: result first first key inputValue equals: 'final'.
	self assert: result first first value equals: Color purple.

	self parse: 'initial and final state "Single" as "only"' rule: #state.
	self assert: result first first key inputValue equals: 'initial and final'.
	self assert: result first first value equals: Color purple.
	self assert: result third key key inputValue equals: '"Single"'.
	self assert: result third value key inputValue equals: '"only"'
]
