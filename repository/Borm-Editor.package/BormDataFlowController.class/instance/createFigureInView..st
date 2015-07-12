private
createFigureInView: aView
	| container |
	container := self createContainerShape element.
	container @ RTDraggable.

	labelFigure := (RTLabel new height: 10; color: Color black) elementOn: ''.
	DCTRConstraint stick: labelFigure onTheTopCenterOf: container trachelShape.
	iconFigure := (RTBitmap new form: BormEditorIcons current dataFlowLeftIcon) element.
	iconFigure trachelShape computeRectangle.	"This is a must, otherwise the view gets corrupted for unknown reason. This is not needed for Participant's icon for some reason."
	DCTRConstraint stick: iconFigure onTheBottomCenterOf: container trachelShape.

	container addCallback: (TRRemoveCallback with: iconFigure with: labelFigure).

	self constraintOnEdge: container.

	aView
		add: container;
		add: iconFigure;
		add: labelFigure.

	^ container