as yet unclassified
baseShape
	^ self figuresFactory newRoundedBox
		width: self defaultSize x;
		height: self defaultSize y;
		color: (Color fromHexString: 'f2f2f2');
		yourself