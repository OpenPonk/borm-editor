userinterface
updateView
	self controllers do: [ :each | each refreshFigure ].
	self view edges
		do: [ :each | 
			each pushBack.
			each update ].
	self view signalUpdate