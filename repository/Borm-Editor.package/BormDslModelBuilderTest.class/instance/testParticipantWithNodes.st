tests
testParticipantWithNodes
	| participant nodes |
	participant := (builder
		processDiagram:
			{{'p1'.
			#().
			{#('a1' '->' 'sMid').
			#('sMid' '->' 'a2')}}}) participants anyOne.
	nodes := participant nodes asSortedCollection: [ :a :b | a name < b name ].
	self assert: nodes size equals: 3.
	self assert: nodes first incoming size equals: 0.
	self assert: nodes first outgoing size equals: 1.
	self assert: nodes second incoming size equals: 1.
	self assert: nodes second outgoing size equals: 0.
	self assert: nodes third incoming size equals: 1.
	self assert: nodes third outgoing size equals: 1