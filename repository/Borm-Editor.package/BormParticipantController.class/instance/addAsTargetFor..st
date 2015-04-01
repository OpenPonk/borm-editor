adding
addAsTargetFor: aNodeController
	| newNode |
	self assert: (self canBeTargetFor: aNodeController).
	aNodeController diagramController: self diagramController.
	newNode := aNodeController createModel.
	self model add: newNode.
	aNodeController model: newNode.
	self diagramController controllers add: aNodeController.
	aNodeController attach.
	elements add: aNodeController figure