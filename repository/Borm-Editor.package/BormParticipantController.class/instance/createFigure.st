hooks
createFigure
	^ DCRTCallbackBuilder
		block: [ :view | 
			| container labelled |
			container := self createContainerFigure.
			container @ RTDraggableSnapToGrid @ RTResizable.
			(labelled := RTLabelled new)
				view: view;
				top;
				color: Color black.
			container @ labelled.
			(RTConstraint on: labelled lbl background: container)
				topLeft;
				padding: 5;
				stick.

			iconElement := (RTBitmap new form: self typeIconForModel) element.
			view add: iconElement.

			(RTConstraint on: iconElement background: container)
				topRight;
				padding: 5;
				stick.

			container addCallback: (TRRemoveCallback with: iconElement).

			elements := RTGroup new.
			elements @ RTDraggable.

			container trachelShape
				addCallback: (TRTranslationCallback block: [ :shape :step | elements do: [ :e | e translateBy: step ] ]).

			container ]