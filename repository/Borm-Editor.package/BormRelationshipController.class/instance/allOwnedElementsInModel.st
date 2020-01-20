accessing
allOwnedElementsInModel
	model hasConstraint
		ifTrue: [ ^ {model constraint} ].
	^ {}