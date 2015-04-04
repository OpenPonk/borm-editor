adding
addAsTargetFor: aDataFlowController
	| newDataFlow |
	self assert: (self canBeTargetFor: aDataFlowController).
	aDataFlowController diagramController: self diagramController.
	newDataFlow := aDataFlowController createModel.
	self model addDataFlow: newDataFlow.
	aDataFlowController model: newDataFlow.
	self diagramController controllers add: aDataFlowController.
	aDataFlowController attach