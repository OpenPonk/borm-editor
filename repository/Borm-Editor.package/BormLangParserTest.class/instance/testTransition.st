tests
testTransition
	self parse: 'go to "vertex"' rule: #transition.
	self assert: result equals: #('vertex' nil).

	self parse: 'go to "vertex" if "condition"' rule: #transition.
	self assert: result equals: #('vertex' 'condition')