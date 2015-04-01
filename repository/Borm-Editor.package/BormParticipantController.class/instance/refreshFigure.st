hooks
refreshFigure
	(figure attributeAt: #RTLabelledLabel) text: self model name.
	figure trachelShape pushBack.
	iconElement trachelShape form: self typeIconForModel.
	self diagramController view signalUpdate