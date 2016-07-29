specs
defaultSpec
	^ SpecLayout composed
		newColumn: [ :col | 
			col
				newRow: [ :row | 
					row
						add: #searchInput;
						add: #addEntryButton ]
					height: ComposableModel toolbarHeight;
				add: #entriesList ];
		yourself