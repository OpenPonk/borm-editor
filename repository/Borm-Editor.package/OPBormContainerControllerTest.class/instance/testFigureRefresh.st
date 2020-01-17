accessing
testFigureRefresh
	| text |
	controller createModelIn: diagramController model.
	diagramController addController: controller.
	controller renderFigureIn: diagramController view.
	self assert: (controller figure attributeAt: #RTLabelledLabel) text = ''.
	controller model name: 'new name'.
	controller refreshFigure.
	text := (controller figure attributeAt: #RTLabelledLabel) text.
	self assert: ((text last: 8) = 'new name' or: [ (text first: 8) = 'new name' ])