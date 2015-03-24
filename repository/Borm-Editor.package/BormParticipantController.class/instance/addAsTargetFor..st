adding
addAsTargetFor: aNodeController
	| newNode newFigure |
	self assert: (self canBeTargetFor: aNodeController).
	aNodeController parent: self parent.
	newNode := aNodeController createModel.
	self model add: newNode.
	aNodeController model: newNode.
	self parent controllers add: aNodeController.
	newFigure := aNodeController figure.
	elements add: newFigure.
	newFigure view ifNil: [ self parent view add: newFigure ].
	self parent figureAdded: newFigure.