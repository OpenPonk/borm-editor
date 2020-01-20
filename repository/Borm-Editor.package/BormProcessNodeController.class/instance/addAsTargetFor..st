adding
addAsTargetFor: aController
	self assert: (self canBeTargetFor: aController).
	aController target: self.
	aController
		createModelIn: self model
		andShowInDiagram: self diagramController