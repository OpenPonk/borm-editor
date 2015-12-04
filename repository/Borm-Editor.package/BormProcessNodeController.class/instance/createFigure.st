hooks
createFigure
	^ DCRTCallbackBuilder
		block: [ :view | 
			| element shape |
			shape := self createShape.
			element := shape elementOn: ''.
			element
				@
					(RTLabelled new
						view: view;
						center;
						fontSize: 10;
						color: Color black;
						yourself).
			element @ RTDraggableSnapToGrid @ RTResizable.
			element ]