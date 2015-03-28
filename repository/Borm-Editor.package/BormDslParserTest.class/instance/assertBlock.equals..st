asserting
assertBlock: aString equals: anArray
	self assert: (parser parse: aString) equals: anArray