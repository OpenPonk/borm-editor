construction
renderFigureIn: aView
	figure := self
		createEdgeFrom: self source figure
		to: self target figure.
	figure @ OPRTConnectionHandles.
	figure renderIn: aView.
	figure trachelShape pushFront.
	self diagramController figureAdded: figure.
	^ figure