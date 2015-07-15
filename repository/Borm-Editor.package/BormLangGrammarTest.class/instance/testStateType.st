tests
testStateType
	self parse: 'initial' rule: #stateType.
	self assert: result equals: 'initial'.
	
	self parse: 'final' rule: #stateType.
	self assert: result equals: 'final'.

	self fail: 'nothing' rule: #stateType