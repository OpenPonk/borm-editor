tests
testTransitions
	self parse: '' rule: #transitions.
	self assert: result equals: #().

	self parse: 'go to "activity"' rule: #transitions.
	self assert: result equals: #(#('activity' nil)).

	self parse: 'go to "activity" if "x" go to "state" if "y"' rule: #transitions.
	self assert: result equals: #(#('activity' 'x') #('state' 'y'))