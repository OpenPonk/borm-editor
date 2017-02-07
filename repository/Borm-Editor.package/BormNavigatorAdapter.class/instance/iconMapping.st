widget API
iconMapping
	^ Array
		with: BormNavigatorEntities -> BormEditorIcons current entity16Icon
		with: BormNavigatorNode -> [ :o | Smalltalk ui icons addIcon ]
		with:
			OPModelObject
				->
					[ :o | BormEditorIcons current perform: ((self bormNameFor: o) uncapitalized , '16Icon') asSymbol ]