widget API
iconMapping
	^ {(DCModelObject
		-> [ :o | BormEditorIcons current perform: ((self bormNameFor: o) uncapitalized , '16Icon') asSymbol ])}