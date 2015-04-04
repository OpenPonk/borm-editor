private
createFigureInView: aView
	| element shape |
	shape := self createShape.
	element := shape elementOn: ''.
	element
		@
			(RTLabelled new
				view: aView;
				center;
				color: Color black;
				yourself).

	playBox := RTSVGPath new
		color: Color green;
		borderColor: Color black;
		path: 'M 0 0 L 15 7 L 0 15 Z';
		element.
	aView add: playBox.
	DCTRConstraint stick: playBox trachelShape onTheCenterRightOf: element trachelShape.
	element addCallback: (TRRemoveCallback with: playBox).

	innerBox := RTBox new
		color: Color transparent;
		borderColor: Color black;
		element.
	element addCallback: (TRRemoveCallback with: innerBox).
	"		aView add: innerBox."

	element @ RTDraggable @ DCRTResizable.

	element trachelShape
		addCallback:
			(TRTranslationCallback
				block: [ :aShape :step | 
					innerBox
						width: aShape width - 10;
						height: element height - 10.
					innerBox translateTo: element position + (0 @ 0) ]).


	^ element