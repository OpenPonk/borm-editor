updating
refreshList
	| search |
	search := searchInput text asLowercase.
	entriesList
		items:
			(itemsBlock value , orphanedItems
				select: [ :each | (displayNameBlock value: each) asLowercase includesSubstring: search ])