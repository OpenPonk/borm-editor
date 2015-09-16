testing
canBeTargetFor: aController
	^ (self canBeTargetForDataFlow: aController)
		or: [ self canBeTargetForConstraint: aController ]