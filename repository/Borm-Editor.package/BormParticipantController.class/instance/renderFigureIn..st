hooks
renderFigureIn: aView
	| labeled |
	figure := self createContainerFigure.
	figure
		@ RTGhostDraggable;
		@ RTResizable.
	(labeled := RTLabeled new)
		view: aView;
		top;
		color: Color black.
	figure @ labeled.
	labelConstraint := (RTConstraint on: labeled lbl background: figure)
		topLeft;
		padding: 5;
		stick.
	figure renderIn: aView.
	iconElement := (RTBitmap new form: self typeIconForModel) element.
	iconElement renderIn: aView.
	(RTConstraint on: iconElement background: figure)
		topRight;
		padding: 5;
		stick.
	figure addCallback: (TRRemoveCallback with: iconElement).
	elements := RTGroup new.
	elements @ RTDraggable.
	figure trachelShape
		addCallback:
			(TRTranslationCallback
				block: [ :shape :step | elements do: [ :e | e translateBy: step ] ]).
	self saveStateOnDragEndFor: figure.
	self diagramController figureAdded: figure.
	^ figure