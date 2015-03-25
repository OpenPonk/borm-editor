adding
addAsTargetFor: aController
	self assert: (self canBeTargetFor: aController).
	self addConnection: aController