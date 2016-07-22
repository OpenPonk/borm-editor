testing
addAsTargetFor: aController
	super addAsTargetFor: aController.
	aController figure translateBy: (aController figure width / 2.5) @ (aController figure height / 2.2)