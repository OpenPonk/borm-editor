hooks
createShape
	| shape |
	shape := RTRoundedBox new
		width: 100;
		height: 40;
		color: (Color fromHexString: 'f2f2f2');
		borderColor: Color black;
		borderRadius: 20.
	^ shape