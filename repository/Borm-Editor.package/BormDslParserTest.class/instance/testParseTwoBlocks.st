tests
testParseTwoBlocks
	self
		assertDiagram:
			'p1(''my participant''){
s1 -> a1
}
p2(''second''){
s2 -> a2
}'
		equals:
			{#('p1' #('my participant') #(#('s1' '->' 'a1'))).
			#('p2' #('second') #(#('s2' '->' 'a2')))}