userinterface
updateView
	self controllers do: [ :each | each refreshFigure ].
	self view edges
		do: [ :each | 
			each pushFront.
			each update ].
	self view signalUpdate