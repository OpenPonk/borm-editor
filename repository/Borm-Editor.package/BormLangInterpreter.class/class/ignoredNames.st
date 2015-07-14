accessing
ignoredNames
	^ super ignoredNames, #(incompleteTransitions nodesLookup incompleteCommunications participantsLookup)