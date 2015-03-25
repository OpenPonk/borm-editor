testing
canBeTargetFor: aController
	^ (aController isKindOf: BormTransitionController) and: [ aController source isKindOf: BormActivityController ]