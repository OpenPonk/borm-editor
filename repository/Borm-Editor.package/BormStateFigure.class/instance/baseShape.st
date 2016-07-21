as yet unclassified
baseShape
	^ self figuresFactory newRoundedBox
		width: self defaultSize x;
		height: self defaultSize y;
		borderRadius: 5;
		yourself