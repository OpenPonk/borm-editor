layouting
layoutParticipant: aParticipant
	| ctrl bounds |
	ctrl := diagramController controllerForModel: aParticipant.
	RTTreeLayout new
		horizontalGap: 30;
		verticalGap: 30;
		on: ctrl nodeFigures.
	bounds := ctrl nodeFigures asGroup encompassingRectangle.
	bounds := bounds expandBy: 20 @ 10.
	RTNest new resizeWithoutRecursion: ctrl figure bounds: bounds