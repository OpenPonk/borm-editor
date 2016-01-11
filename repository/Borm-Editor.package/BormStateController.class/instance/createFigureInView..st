private
createFigureInView: aView
	| element shape |
	shape := self createShape.
	element := shape elementOn: ''.
	aView add: element.
	element
		@
			(RTLabelled new
				view: aView;
				center;
				fontSize: 10;
				color: Color black;
				yourself).

	playBox := RTBitmap new
		form: BormEditorIcons current initialIcon;
		element.

	(RTConstraint on: playBox background: element)
		right;
		padding: 5;
		stick.

	element addCallback: (TRRemoveCallback with: playBox).

	innerBox := RTBox new
		color: Color transparent;
		borderColor: Color black;
		element.
	element addCallback: (TRRemoveCallback with: innerBox).
	"		aView add: innerBox."

	element @ RTDraggableSnapToGrid @ RTResizable.

	element trachelShape
		addCallback:
			(TRTranslationCallback
				block: [ :aShape :step | 
					innerBox
						width: aShape width - 10;
						height: element height - 10.
					innerBox translateTo: element position + (0 @ 0) ]).


	^ element