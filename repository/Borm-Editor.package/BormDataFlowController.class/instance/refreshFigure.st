hooks
refreshFigure
	labelFigure trachelShape text: self model name.
	figure width: (labelFigure width max: 40).
	self refreshIcon.
	self diagramController view signalUpdate.