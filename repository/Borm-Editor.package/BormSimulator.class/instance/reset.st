shapes
reset
	states valuesDo: #remove.
	states removeAll.
	self view signalUpdate.