asserting
assertEdge: aString equals: anArray
	self assert: (parser parseEdge: aString) equals: anArray