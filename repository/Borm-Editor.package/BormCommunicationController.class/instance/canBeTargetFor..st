testing
canBeTargetFor: aController
	aController isKindOf: BormDataFlowController.
	^ (self canBeTargetForDataFlow: aController) or: [ self canBeTargetForConstraint: aController ]