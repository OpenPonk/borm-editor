hooks
createFigure
	| element |
	element := RTLabel new
		color: Color black;
		elementOn: 'empty constraint'.
	element @ RTDraggable.
	self constraintOnEdge: element.
	^ element