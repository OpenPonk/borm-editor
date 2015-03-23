hooks
createFigure
	| element shape |
	shape := RTBox new
		size: 50;
		color: Color paleBlue;
		borderColor: Color gray.
	element := shape element.
	element @ RTDraggable @ DCRTResizable @ DCRTFocusable.
	^ element