adding
addConnection: aController
	| newModel newFigure |
	aController target: self.
	aController parent: self parent.
	newModel := aController createModel.
	aController model: newModel.
	self parent controllers add: aController.
	newFigure := aController figure.
	newFigure view ifNil: [ self parent view add: newFigure ].
	self parent figureAdded: newFigure