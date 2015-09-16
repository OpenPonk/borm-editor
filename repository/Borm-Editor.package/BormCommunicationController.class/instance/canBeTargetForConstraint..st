testing
canBeTargetForConstraint: aController
	^ self model hasConstraint not and: [ aController isKindOf: BormConstraintController ]