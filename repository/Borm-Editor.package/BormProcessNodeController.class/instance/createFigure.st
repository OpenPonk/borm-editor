hooks
createFigure
	| element shape |
	shape := self shapeClass new
		size: 50;
		borderColor: Color gray.
	element := shape element.
	element @ RTDraggable @ DCRTResizable.
	^ element