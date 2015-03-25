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
						color: Color black;
						yourself).
			element @ RTDraggable @ DCRTResizable.
			element ]