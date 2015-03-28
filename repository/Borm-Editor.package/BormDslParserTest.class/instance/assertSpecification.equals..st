asserting
assertSpecification: aString equals: anArray
	self assert: (parser parseSpecification: aString) equals: anArray