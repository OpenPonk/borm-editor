private
createFigureInView: aView
	| container |
	container := self createContainerShape element.
	container @ RTDraggable.

	labelFigure := (RTLabel new color: Color black) elementOn: ''.
	DCTRConstraint stick: labelFigure onTheTopCenterOf: container trachelShape.
"	iconFigure := (RTBitmap new form: BormEditorIcons current dataFlowRightIcon) element.
	DCTRConstraint stick: iconFigure onTheBottomCenterOf: container trachelShape."

	container addCallback: (TRRemoveCallback "with: iconFigure" with: labelFigure).
	
	self constraintOnEdge: container.

	aView
		add: container;
"		add: iconFigure;"
		add: labelFigure.

	^ container