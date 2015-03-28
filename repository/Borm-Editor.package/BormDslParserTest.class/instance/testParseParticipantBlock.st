tests
testParseParticipantBlock
	self
		assertBlock:
			'p1(''my participant''){
s1 -> a1
}'
		equals: #('p1' #('my participant') #(#('s1' '->' 'a1')))