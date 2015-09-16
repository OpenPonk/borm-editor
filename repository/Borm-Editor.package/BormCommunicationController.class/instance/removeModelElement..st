removing
removeModelElement: anElement
	anElement class = BormDataFlow
		ifTrue: [ self model removeDataFlow: anElement ]
		ifFalse: [ self model removeConstraint ]