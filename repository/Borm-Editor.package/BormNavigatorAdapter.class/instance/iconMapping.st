widget API
iconMapping
	^ Array
		with: BormNavigatorNode -> [ :o | Smalltalk ui icons addIcon ]
		with: BormEntity -> [ :o | Smalltalk ui icons blankIcon ]
		with:
			DCModelObject
				->
					[ :o | BormEditorIcons current perform: ((self bormNameFor: o) uncapitalized , '16Icon') asSymbol ]