converting
node: aNode
	^ ((aNode isKindOf: BormActivity)
		ifTrue: [ self activityNode: aNode ]
		ifFalse: [ self state: aNode ]) , (self newLineIf: aNode outgoing isNotEmpty), (self transitions: aNode outgoing)