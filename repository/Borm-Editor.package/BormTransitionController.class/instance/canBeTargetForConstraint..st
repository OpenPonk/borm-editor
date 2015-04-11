testing
canBeTargetForConstraint: aController
	^ self model hasConstraint not
		and: [ (aController isKindOf: BormConstraintController) and: [ self model source isKindOf: BormState ] ]