accessing
newLineIf: aBoolean
	^ aBoolean
		ifTrue: [ self newLine ]
		ifFalse: [ '' ]