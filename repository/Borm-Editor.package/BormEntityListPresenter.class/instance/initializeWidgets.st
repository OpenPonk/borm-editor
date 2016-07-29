initialization
initializeWidgets
	searchInput := self newTextInput.
	searchInput
		autoAccept: true;
		entryCompletion: nil;
		ghostText: 'Search'.
	addEntryButton := self newButton.
	addEntryButton label: 'New Entry'.
	entriesList := self instantiate: FastTableModel.
	self focusOrder
		add: searchInput;
		add: addEntryButton;
		add: entriesList