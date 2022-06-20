Class {
	#name : #BormEntityListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'searchInput',
		'addEntryButton',
		'entriesList',
		'itemsBlock',
		'displayNameBlock',
		'orphanedItems'
	],
	#category : #'OpenPonk-BormEditor-UI'
}

{ #category : #'as yet unclassified' }
BormEntityListPresenter class >> defaultLayout [
	^ SpecLayout composed
		add: SpBoxLayout newTopToBottom:  [ :col | 
			col
				add: SpBoxLayout newLeftToRight:  [ :row | 
					row
						add: #searchInput;
						add: #addEntryButton ]
					height: ComposableModel toolbarHeight;
				add: #entriesList ];
		yourself
]

{ #category : #specs }
BormEntityListPresenter class >> defaultSpec [

	self flag: 'Pharo 9- compatibility'.
	^ self defaultLayout
]

{ #category : #'accessing - spec fields' }
BormEntityListPresenter >> addEntryButton [
	^ addEntryButton
]

{ #category : #accessing }
BormEntityListPresenter >> addEntryLabel: aString [
	addEntryButton label: aString
]

{ #category : #'as yet unclassified' }
BormEntityListPresenter >> connectPresenters [

	super connectPresenters.
	searchInput whenTextChanged: [ self refreshList ].
	addEntryButton action: [ self openEntryEditor ].
	entriesList
		displayBlock: displayNameBlock;
		doubleClickAction: [ 
			self openEntryEditorOn: entriesList selectedItem ]
]

{ #category : #accessing }
BormEntityListPresenter >> displayNameBlock: aOneArgBlock [
	displayNameBlock := aOneArgBlock.
	entriesList displayBlock: displayNameBlock
]

{ #category : #'accessing - spec fields' }
BormEntityListPresenter >> entriesList [
	^ entriesList
]

{ #category : #initialization }
BormEntityListPresenter >> initialize [
	orphanedItems := OrderedCollection new.
	itemsBlock := [ #() ].
	displayNameBlock := [ :item | item name ].
	super initialize
]

{ #category : #'as yet unclassified' }
BormEntityListPresenter >> initializePresenters [
	searchInput := self newTextInput.
	searchInput
		autoAccept: true;
		entryCompletion: nil;
		ghostText: 'Search'.
	addEntryButton := self newButton.
	addEntryButton label: 'New Entry'.
	entriesList := self newList.
	self focusOrder
		add: searchInput;
		add: addEntryButton;
		add: entriesList
]

{ #category : #accessing }
BormEntityListPresenter >> itemsBlock: aBlock [
	itemsBlock := aBlock.
	self refreshList
]

{ #category : #actions }
BormEntityListPresenter >> openEntryEditor [
	self openEntryEditorOn: BormEntity new isNew: true
]

{ #category : #actions }
BormEntityListPresenter >> openEntryEditorOn: anEntry [
	self openEntryEditorOn: anEntry isNew: false
]

{ #category : #actions }
BormEntityListPresenter >> openEntryEditorOn: anEntry isNew: isNew [
	| control pane nameField |
	control := WizardControl new.
	pane := WizardSinglePane new.
	pane name: 'New Entity'.
	nameField := TextFieldPart new
		inGroupboxNamed: 'Entity name';
		defaultValue: anEntry name;
		horizontalSize: 300;
		yourself.
	pane addPart: nameField associatedTo: #name.
	control addPane: pane.
	control
		atEndDo: [ :vals | 
			anEntry name: (vals at: #name).
			isNew
				ifTrue: [ orphanedItems add: anEntry ].
			self refreshList ].
	control open
]

{ #category : #updating }
BormEntityListPresenter >> refreshList [
	| search |
	search := searchInput text asLowercase.
	entriesList
		items:
			(itemsBlock value , orphanedItems
				select: [ :each | (displayNameBlock value: each) asLowercase includesSubstring: search ])
]

{ #category : #'accessing - spec fields' }
BormEntityListPresenter >> searchInput [
	^ searchInput
]

{ #category : #accessing }
BormEntityListPresenter >> selectedItem [
	^ entriesList selectedItem
]
