hooks
createFigure
	| fig |
	fig := BormActivityFigure on: self model.
	fig plusIcon
		when: TRMouseLeftClick
		do: [ self diagramController editor workbench openEditorOn: self model submodel ].
	^ fig