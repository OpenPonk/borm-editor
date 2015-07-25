private
createFigureInView: aView
	| container |
	container := self createContainerShape element.
	container @ RTDraggable.

	labelFigure := (RTLabel new
		height: 10;
		color: Color black) elementOn: ''.
	(RTConstraint on: labelFigure background: container)
		top;
		stick.

	iconFigure := (RTBitmap new form: BormEditorIcons current dataFlowLeftIcon) element.
	iconFigure trachelShape computeRectangle.	"This is a must, otherwise the view gets corrupted for unknown reason. This is not needed for Participant's icon for some reason."
	(RTConstraint child: iconFigure parent: container trachelShape)
		bottom;
		padding: 5;
		stick.

	container addCallback: (TRRemoveCallback with: iconFigure with: labelFigure).

	self constraintOnEdge: container.

	aView
		add: container;
		add: iconFigure;
		add: labelFigure.

	^ container