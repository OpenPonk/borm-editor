hooks
createFigure
	^ DCRTCallbackBuilder
		block: [ :view | 
			| container labelled |
			container := self createContainerFigure.
			container @ RTDraggable @ DCRTResizable.
			(labelled := RTLabelled new)
				view: view;
				top;
				color: Color black.
			container @ labelled.
			TRConstraint stick: labelled lbl onTheTopLeftOf: container trachelShape.

			iconElement := (RTBitmap new form: self typeIconForModel) element.
			view add: iconElement.
			DCTRConstraint stick: iconElement trachelShape onTheTopRightOf: container trachelShape.
			container addCallback: (TRRemoveCallback block: [ iconElement remove ]).

			elements := RTGroup new.
			elements @ RTDraggable.

			container trachelShape
				addCallback: (TRTranslationCallback block: [ :shape :step | elements do: [ :e | e translateBy: step ] ]).

			container ]