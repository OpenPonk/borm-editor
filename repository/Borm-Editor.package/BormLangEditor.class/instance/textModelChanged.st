events
textModelChanged
	| text newModel success |
	self logCr: 'textModelChanged'.
	text := self textModel widget text.
	success := true.
	newModel := [ BormLangParser parse: text onError: [ success := false ] ] ifError: [ success := false ].
	self logCr: success.
	success
		ifTrue: [ BormFactory moveParticipantsFrom: newModel to: bormDiagram ]