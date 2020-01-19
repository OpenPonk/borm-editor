private
renderFigureIn: aView
	figure := self createContainerShape element.
	figure @ RTDraggable.
	labelFigure := (RTLabel new
		height: 10;
		color: Color black) elementOn: ''.
	(RTConstraint on: labelFigure background: figure)
		top;
		stick.
	iconFigure := (RTBitmap new
		form: BormEditorIcons current dataFlowLeftIcon) element.
	(RTConstraint on: iconFigure background: figure trachelShape)
		bottom;
		padding: 5;
		stick.
	figure
		addCallback: (TRRemoveCallback with: iconFigure with: labelFigure).
	aView
		add: figure;
		add: iconFigure;
		add: labelFigure.
	self constraintOnEdge: figure.
	self saveStateOnDragEndFor: figure.
	^ figure