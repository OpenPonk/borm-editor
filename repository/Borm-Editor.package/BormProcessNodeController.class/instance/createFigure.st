hooks
createFigure
	^ DCRTCallbackBuilder
		block: [ :view | 
			| element shape |
			shape := self createShape.
			element := shape elementOn: ''.
			element
				@
					(RTLabeled new
						view: view;
						center;
						fontSize: 10;
						color: Color black;
						yourself).
			(RTConstraint on: plusBox background: element)
				right;
				bottom;
				padding: 5;
				stick.
			element addCallback: (TRRemoveCallback with: plusBox).
			element @ RTDraggableSnapToGrid @ RTResizable.
			self saveStateOnDragEndFor: element.
			element ]