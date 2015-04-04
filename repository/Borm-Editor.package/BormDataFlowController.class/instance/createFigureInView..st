private
createFigureInView: aView
	| container icon |
	container := self createContainerShape element.
	container @ RTDraggable.

	labelFigure := (RTLabel new color: Color black) elementOn: 'Data Flow Change Me'.
	DCTRConstraint stick: labelFigure onTheTopCenterOf: container trachelShape.
	icon := (RTBitmap new form: BormEditorIcons current dataFlowIcon) element.
	DCTRConstraint stick: icon onTheBottomCenterOf: container trachelShape.

	container addCallback: (TRRemoveCallback with: icon with: labelFigure).

	aView
		add: container;
		add: icon;
		add: labelFigure.

	^ container