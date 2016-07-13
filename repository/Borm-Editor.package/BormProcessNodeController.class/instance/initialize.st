as yet unclassified
initialize
	super initialize.
	plusBox := RTBitmap new
		form: Smalltalk ui icons smallAddIcon;
		element.
	plusBox
		when: TRMouseLeftClick
		do: [ self diagramController editor workbench openEditorOn: self model submodel ]