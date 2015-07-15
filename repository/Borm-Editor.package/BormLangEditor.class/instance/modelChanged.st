events
modelChanged
	|newText|
	self logCr: 'modelChanged'.
	newText := serializer diagram: bormDiagram.
	newText = self textModel widget text ifFalse: [ 
		self logCr: 'CHANGE'
	]
	"self textModel widget updateTextWith: (serializer diagram: bormDiagram)"