hooks
refreshFigure
	labelFigure trachelShape text: self model name.
"	figure trachelShape pushBack."
	figure width: (labelFigure width max: 40).
	self diagramController view signalUpdate