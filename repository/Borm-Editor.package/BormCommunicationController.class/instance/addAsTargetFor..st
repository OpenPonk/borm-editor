adding
addAsTargetFor: aController
	self assert: (self canBeTargetFor: aController).
	(self canBeTargetForDataFlow: aController)
		ifTrue: [ self addAsTargetForDataFlow: aController ].
	(self canBeTargetForConstraint: aController)
		ifTrue: [ self addAsTargetForConstraint: aController ]