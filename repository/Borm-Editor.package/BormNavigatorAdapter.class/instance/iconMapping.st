widget API
iconMapping
	^ Array
		with: BormNavigatorEntities -> BormEditorIcons current entity16Icon
		with: BormNavigatorNode -> [ :o | Smalltalk ui icons addIcon ]
		with:
			DCModelObject
				->
					[ :o | BormEditorIcons current perform: ((self bormNameFor: o) uncapitalized , '16Icon') asSymbol ]