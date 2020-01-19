hooks
renderFigureIn: aView
	figure := BormStateFigure on: self model.
	figure renderIn: aView.
	figure plusIcon
		when: TRMouseLeftClick
		do: [ self diagramController editor workbench
				openEditorOn: self model submodel ].
	self diagramController figureAdded: figure.
	^ figure