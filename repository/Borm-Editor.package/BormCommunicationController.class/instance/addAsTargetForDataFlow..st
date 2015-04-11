adding
addAsTargetForDataFlow: aDataFlowController
	| newDataFlow |
	self assert: (self canBeTargetForDataFlow: aDataFlowController).
	aDataFlowController diagramController: self diagramController.
	newDataFlow := aDataFlowController createModel.
	self model addDataFlow: newDataFlow.
	aDataFlowController model: newDataFlow.
	self diagramController controllers add: aDataFlowController.
	aDataFlowController attach