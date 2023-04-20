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

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #searchInput;
				   add: #addEntryButton;
				   yourself)
		  height: self toolbarHeight;
		  add: #entriesList;
		  yourself
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
	searchInput whenTextChangedDo: [ self refreshList ].
	addEntryButton action: [ self openEntryEditor ].
	entriesList
		display: displayNameBlock;
		whenActivatedDo: [ self openEntryEditorOn: entriesList selectedItem ]
]

{ #category : #accessing }
BormEntityListPresenter >> displayNameBlock: aOneArgBlock [
	displayNameBlock := aOneArgBlock.
	entriesList display: displayNameBlock
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
		entryCompletion: nil;
		placeholder: 'Search'.
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

	| response |
	response := self uiManager
		            request: 'Entity name:'
		            initialAnswer: anEntry name
		            title: (isNew
				             ifTrue: [ 'New entity' ]
				             ifFalse: [ 'Entity' ]).
	response ifNil: [ ^ self ].
	anEntry name: response.
	isNew ifTrue: [ orphanedItems add: anEntry ].
	self refreshList
]

{ #category : #updating }
BormEntityListPresenter >> refreshList [

	| search |
	search := searchInput text asLowercase.
	entriesList items:
		(itemsBlock value asArray , orphanedItems select: [ :each | 
			 (displayNameBlock value: each) asLowercase includesSubstring:
				 search ])
]

{ #category : #'accessing - spec fields' }
BormEntityListPresenter >> searchInput [
	^ searchInput
]

{ #category : #accessing }
BormEntityListPresenter >> selectedItem [
	^ entriesList selectedItem
]
