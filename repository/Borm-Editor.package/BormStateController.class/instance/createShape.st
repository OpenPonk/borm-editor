hooks
createShape
	| shape |
	shape := RTRoundedBox new
		width: 100;
		height: 40;
		color: Color white;
		borderWidth: 1;
		borderColor: Color black;
		borderRadius: 5.
	^ shape