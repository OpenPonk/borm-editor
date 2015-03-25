testing
canBeSourceFor: aController
	^ (aController isKindOf: BormTransitionController) | (aController isKindOf: BormCommunicationController)