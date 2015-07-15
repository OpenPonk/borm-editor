tests
testDiagram2
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