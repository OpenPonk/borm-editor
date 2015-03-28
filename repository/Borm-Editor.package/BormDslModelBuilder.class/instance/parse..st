parsing
parse: aString
	self processDiagram: (BormDslParser new parse: aString).
	^ diagram