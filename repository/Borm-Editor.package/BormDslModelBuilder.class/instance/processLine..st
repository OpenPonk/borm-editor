private - processing
processLine: anArray
	anArray second isArray
		ifTrue: [ ^ self processSpecification: anArray ]
		ifFalse: [ ^ self processEdge: anArray ]