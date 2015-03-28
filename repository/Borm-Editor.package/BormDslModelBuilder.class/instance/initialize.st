initialization
initialize
	super initialize.
	nodes := Dictionary new.
	participants := Dictionary new.
	diagram := BormDiagram new.
	participantNodes := Dictionary new