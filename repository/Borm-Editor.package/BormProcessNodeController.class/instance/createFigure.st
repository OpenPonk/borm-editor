hooks
createFigure
	| element shape |
	shape := self createShape.
	element := shape element.
	element @ RTDraggable @ DCRTResizable.
	^ element