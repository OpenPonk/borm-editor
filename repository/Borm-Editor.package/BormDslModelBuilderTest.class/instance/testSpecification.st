tests
testSpecification
	| item |
	item := builder processSpecification: #('a1' #()).
	self assert: item class equals: BormActivity.
	self assert: item name equals: 'a1'.

	item := builder processSpecification: #('s1' #()).
	self assert: item class equals: BormState.
	self assert: item name equals: 's1'.

	item := builder processSpecification: #('p1' #()).
	self assert: item class equals: BormParticipant.
	self assert: item name equals: 'p1'