as yet unclassified
activityFigure
	| box label plus |
	box := self newRoundedBox
		width: 100;
		height: 400;
		color: (Color fromHexString: 'f2f2f2');
		element.
	label := self newLabel element.
	(RTConstraint on: label background: box) stick.
	plus := RTBitmap new
		form: Smalltalk ui icons smallAddIcon;
		element.
	(RTConstraint on: plus background: box)
		right;
		bottom;
		padding: 5;
		stick.
	box addCallback: (TRRemoveCallback with: label with: plus).
	box @ RTDraggableSnapToGrid @ RTResizable.
	^ box