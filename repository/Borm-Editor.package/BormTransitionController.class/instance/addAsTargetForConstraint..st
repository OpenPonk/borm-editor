adding
addAsTargetForConstraint: aConstraintController
	self assert: (self canBeTargetFor: aConstraintController).
	self model constraint: aConstraintController loadModel.
	aConstraintController attachTo: self diagramController