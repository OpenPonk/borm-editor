parsing
parse: aString
	self processBlock: (BormDslParser new parse: aString).
	^ participant