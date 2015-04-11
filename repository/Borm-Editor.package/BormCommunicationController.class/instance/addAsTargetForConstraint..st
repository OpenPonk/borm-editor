adding
addAsTargetForConstraint: aConstraintController
	self assert: (self canBeTargetForConstraint: aConstraintController).
	self model constraint: aConstraintController loadModel.
	aConstraintController attachTo: self diagramController