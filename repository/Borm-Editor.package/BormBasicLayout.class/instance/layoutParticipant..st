layouting
layoutParticipant: aParticipant
	| ctrl bounds |
	ctrl := diagramController controllerForModel: aParticipant.
	aParticipant nodes do: [ :each | self layoutNode: each ].
"	RTSugiyamaLayout new"
	RTDominanceTreeLayout new
		horizontalGap: 30;
		verticalGap: 30;
		on: ctrl nodeFigures.
	bounds := ctrl nodeFigures asGroup encompassingRectangle.
	bounds := bounds expandBy: 40 @ 30.
	RTNest new resizeWithoutRecursion: ctrl figure bounds: bounds