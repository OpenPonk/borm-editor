testing
canBeTargetFor: aController
	^ ((aController isKindOf: BormTransitionController) and: [ aController source isKindOf: BormStateController ])
		| ((aController isKindOf: BormCommunicationController) and: [ aController source model owner ~= self model owner ])