hooks
createFigure
	| container |
	container := self createContainerFigure.
	container @ RTDraggable @ DCRTResizable.

	elements := RTGroup new.
	elements @ RTDraggable.

	container trachelShape
		addCallback: (TRTranslationCallback block: [ :shape :step | elements do: [ :e | e translateBy: step ] ]).

	^ container