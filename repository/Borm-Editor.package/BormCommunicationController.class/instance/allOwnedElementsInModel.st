accessing
allOwnedElementsInModel
	| dataFlows |
	dataFlows := model dataFlows.
	model hasConstraint
		ifTrue: [ ^ dataFlows , {model constraint} ].
	^ dataFlows