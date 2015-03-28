tests
testParseBlock
	self
		assertBlock:
			'p1(''my participant''){
s1(s1, p1, initial)
s1 -> a1
s2(s2, final)
a1 -> s2
}'
		equals:
			{'p1'.
			#('my participant').
			{#('s1' #('s1' 'p1' #initial)).
			#('s1' '->' 'a1').
			#('s2' #('s2' 'final')).
			#('a1' '->' 's2')}}