testing
canBeTargetFor: aController
	^ (aController isKindOf: BormTransitionController) & (aController source isKindOf: BormStateController)
		| ((aController isKindOf: BormCommunicationController) & (aController source model owner ~= self model owner))