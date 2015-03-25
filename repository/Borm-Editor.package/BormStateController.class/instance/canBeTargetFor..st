testing
canBeTargetFor: aController
	^ (aController isKindOf: BormTransitionController) & (aController source isKindOf: BormActivityController)