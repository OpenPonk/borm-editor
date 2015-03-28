asserting
assertBlock: aString equals: anArray
	self assert: (parser parseBlock: aString) equals: anArray