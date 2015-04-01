adding
addConnection: aController
	| newModel |
	aController target: self.
	aController diagramController: self diagramController.
	newModel := aController createModel.
	aController model: newModel.
	self diagramController controllers add: aController.
	aController attach