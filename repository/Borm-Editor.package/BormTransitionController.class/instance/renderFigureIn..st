construction
renderFigureIn: aView
	figure := super renderFigureIn: aView.
	(self diagramController controllerForModel: self model source owner)
		figure trachelShape
		addCallback:
			(TRTranslationCallback
				block: [ :sh :step | figure shape translateBy: step for: figure ]).
	^ figure