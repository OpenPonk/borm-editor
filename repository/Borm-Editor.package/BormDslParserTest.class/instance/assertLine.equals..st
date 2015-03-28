asserting
assertLine: aString equals: anArray
	self assert: (parser parseLine: aString) equals: anArray