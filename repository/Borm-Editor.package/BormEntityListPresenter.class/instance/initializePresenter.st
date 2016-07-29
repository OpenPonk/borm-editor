initialization
initializePresenter
	super initializePresenter.
	searchInput whenTextChanged: [ self refreshList ].
	addEntryButton action: [ self openEntryEditor ].
	entriesList
		displayBlock: displayNameBlock;
		handlesDoubleClick: true;
		doubleClickAction: [ self openEntryEditorOn: entriesList selectedItem ]