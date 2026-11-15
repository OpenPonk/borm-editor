"
Unit tests for the textual BORM DSL editor presenter, covering Spec 2 layout and window initialization, model-to-text serialization with syntax highlighting, text-to-model parsing and error line coloring, in-memory file loading and saving, toolbar actions, and model menu command execution.
"
Class {
	#name : 'OPDslEditorTest',
	#superclass : 'TestCase',
	#instVars : [
		'dslEditor',
		'existingWindows',
		'memoryFileSystem'
	],
	#category : 'OpenPonk-BormEditor-Tests-Dsl',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Dsl'
}

{ #category : 'helpers' }
OPDslEditorTest >> colorsAt: anIndex in: aText [

	^ (aText attributesAt: anIndex)
		  select: [ :eachAttribute | eachAttribute isKindOf: TextColor ]
		  thenCollect: [ :eachAttribute | eachAttribute color ]
]

{ #category : 'helpers' }
OPDslEditorTest >> newConfiguredEditor [

	^ OPDslEditor new
		  parser: BormLangParser new;
		  exporter: BormLangSerializer new;
		  highlighter: BormLangHighlighter new;
		  modelClass: BormORModel;
		  yourself
]

{ #category : 'running' }
OPDslEditorTest >> setUp [

	super setUp.
	existingWindows := (self currentWorld submorphs select: [ :eachMorph | eachMorph isSystemWindow ]) asIdentitySet.
	memoryFileSystem := FileSystem memory
]

{ #category : 'running' }
OPDslEditorTest >> tearDown [

	existingWindows ifNotNil: [
			self currentWorld submorphs
				select: [ :eachMorph | eachMorph isSystemWindow and: [ (existingWindows includes: eachMorph) not ] ]
				thenDo: [ :eachWindow | eachWindow delete ] ].
	dslEditor := nil.
	memoryFileSystem := nil.
	existingWindows := nil.
	super tearDown
]

{ #category : 'tests' }
OPDslEditorTest >> testHighlightHandlesNilHighlighterStringsInvalidSyntaxAndNamePairs [

	| sourceText unhighlightedResult highlightedFromString invalidText nameColor |
	nameColor := Color green muchDarker darker.
	dslEditor := self newConfiguredEditor.
	sourceText := 'Person "Customer" {
	activity "Order" as "ord"
}'.
	dslEditor highlighter: nil.
	unhighlightedResult := dslEditor highlight: sourceText asText.
	self assertEmpty: (self colorsAt: 1 in: unhighlightedResult).

	dslEditor highlighter: BormLangHighlighter new.
	highlightedFromString := dslEditor highlight: sourceText.
	self assert: highlightedFromString class identicalTo: Text.
	self assertCollection: (self colorsAt: 1 in: highlightedFromString) includesAll: { Color blue }.
	self
		assertCollection: (self colorsAt: (sourceText indexOfSubCollection: '"Customer"') in: highlightedFromString)
		includesAll: { nameColor }.
	self
		assertCollection: (self colorsAt: (sourceText indexOfSubCollection: 'activity') in: highlightedFromString)
		includesAll: { Color purple }.
	self
		assertCollection: (self colorsAt: (sourceText indexOfSubCollection: '"Order"') in: highlightedFromString)
		includesAll: { nameColor }.
	self
		assertCollection: (self colorsAt: (sourceText indexOfSubCollection: '"ord"') in: highlightedFromString)
		includesAll: { nameColor }.

	invalidText := 'UnknownType "Broken" {}' asText.
	self assert: (dslEditor highlight: invalidText) identicalTo: invalidText.
	self assertEmpty: (self colorsAt: 1 in: invalidText)
]

{ #category : 'tests' }
OPDslEditorTest >> testInitializePresentersLayoutAndWindowConfiguration [

	| window |
	dslEditor := self newConfiguredEditor.
	self assert: dslEditor parser class identicalTo: BormLangParser.
	self assert: dslEditor exporter class identicalTo: BormLangSerializer.
	self assert: dslEditor highlighter class identicalTo: BormLangHighlighter.
	self assert: dslEditor modelClass identicalTo: BormORModel.
	self assert: dslEditor newModel class identicalTo: BormORModel.
	self assert: dslEditor toolbar class identicalTo: SpMenuBarPresenter.
	self assert: dslEditor editor class identicalTo: SpTextPresenter.
	self assert: dslEditor autoUpdate class identicalTo: SpButtonPresenter.
	self assert: dslEditor autoUpdate label equals: 'Refresh from Model'.
	self assert: dslEditor title equals: 'DSL Editor'.

	window := dslEditor asWindow.
	[
		window open.
		self assert: window title equals: 'DSL Editor'.
		self
			assert: (dslEditor editor adapter widget hasRulerNamed: #lineNumbers)
			description: 'DSL text editor widget must enable line numbers when built' ] ensure: [ window close ]
]

{ #category : 'tests' }
OPDslEditorTest >> testSaveToFileAndOpenFromFileModalDialogsViaStubs [

	| menuItems saveItem saveAsItem openItem mockSaveDialog capturedSaveAction savedFile mockOpenDialog capturedOpenAction nestedFile buyerSource fileSource |
	capturedSaveAction := nil.
	capturedOpenAction := nil.
	dslEditor := self newConfiguredEditor.
	menuItems := dslEditor toolbar menuGroups first menuItems.
	saveItem := menuItems detect: [ :eachItem | eachItem name = 'Save' ].
	saveAsItem := menuItems detect: [ :eachItem | eachItem name = 'Save as...' ].
	openItem := menuItems detect: [ :eachItem | eachItem name = 'Open' ].
	buyerSource := 'Person "Buyer" {
}'.
	dslEditor editor text: buyerSource.

	mockSaveDialog := Mock new.
	StSaveFilePresenter stub new willReturn: mockSaveDialog.
	mockSaveDialog stub title: Any.
	mockSaveDialog stub extensions: Any named: Any.
	(mockSaveDialog stub okAction: Any) will: [ :actionBlock | capturedSaveAction := actionBlock ].
	mockSaveDialog stub openModal.

	saveAsItem action value.
	self assert: dslEditor location identicalTo: nil.

	savedFile := memoryFileSystem root / 'dialog-saved.txt'.
	capturedSaveAction value: savedFile.
	self assert: dslEditor location equals: savedFile.
	self assert: savedFile exists description: 'Confirming save dialog must write DSL text to selected file'.
	self assert: savedFile contents equals: buyerSource.
	self assert: (dslEditor model participants collect: #name as: Array) equals: #( 'Buyer' ).

	fileSource := 'Organization "Bank" {
	activity "Approve"
}'.
	nestedFile := memoryFileSystem root / 'nested' / 'loaded.txt'.
	nestedFile parent ensureCreateDirectory.
	nestedFile writeStreamDo: [ :stream | stream nextPutAll: fileSource ].

	mockOpenDialog := Mock new.
	StOpenFilePresenter stub new willReturn: mockOpenDialog.
	mockOpenDialog stub title: Any.
	mockOpenDialog stub extensions: Any named: Any.
	(mockOpenDialog stub okAction: Any) will: [ :actionBlock | capturedOpenAction := actionBlock ].
	mockOpenDialog stub open.

	openItem action value.
	self assert: dslEditor location equals: savedFile.

	capturedOpenAction value: nestedFile.
	self assert: dslEditor location equals: nestedFile.
	self assert: dslEditor editor text asString equals: fileSource.
	self assertCollection: (self colorsAt: 1 in: dslEditor editor text) includesAll: { Color blue }.

	dslEditor editor text: buyerSource.
	saveItem action value.
	self assert: nestedFile contents equals: buyerSource
]

{ #category : 'tests' }
OPDslEditorTest >> testSaveToFileAndTextUpdatedWriteTextToMemoryFileSystem [

	| targetFile initialSource updatedSource |
	dslEditor := self newConfiguredEditor.
	initialSource := 'Person "Seller" {
	state "Idle"
}'.
	dslEditor editor text: initialSource.
	dslEditor editor ensureInternalActions allCommands last execute.

	self assert: dslEditor location identicalTo: nil.
	self assert: (dslEditor model participants collect: #name as: Array) equals: #( 'Seller' ).

	targetFile := memoryFileSystem root / 'sub' / 'model.txt'.
	targetFile parent ensureCreateDirectory.
	dslEditor updateFromModel.
	dslEditor saveToFile: targetFile.

	self assert: dslEditor location equals: targetFile.
	self assert: targetFile exists description: 'Target file must be created in memory file system'.
	self assert: targetFile contents equals: dslEditor editor text asString.

	updatedSource := 'System "Gateway" {
	activity "Route"
}'.
	dslEditor editor text: updatedSource.
	dslEditor textUpdated: dslEditor editor text.

	self assert: targetFile contents equals: updatedSource.
	self assert: (dslEditor model participants collect: #name as: Array) equals: #( 'Gateway' )
]

{ #category : 'tests' }
OPDslEditorTest >> testToolbarActionsAndBormDslEditorCommandExecute [

	| menuItems itemNames newItem openEditorItem openedWorkbench activation command mockEditor mockDiagramController exampleModel commandWindow |
	dslEditor := self newConfiguredEditor.
	menuItems := dslEditor toolbar menuGroups first menuItems.
	itemNames := menuItems collect: #name as: Array.
	self assert: itemNames equals: #( 'New' 'Save' 'Save as...' 'Open' 'Open Editor' ).

	newItem := menuItems detect: [ :eachItem | eachItem name = 'New' ].
	newItem action value.

	dslEditor editor text: 'Person "Operator" {
}'.
	openEditorItem := menuItems detect: [ :eachItem | eachItem name = 'Open Editor' ].
	openedWorkbench := openEditorItem action value.
	[
		self assert: dslEditor model class identicalTo: BormORModel.
		self assert: (dslEditor model participants collect: #name as: Array) equals: #( 'Operator' ).
		self assert: openedWorkbench project models first identicalTo: dslEditor model ] ensure: [
		openedWorkbench ifNotNil: [ openedWorkbench close ] ].

	activation := OPBormDslEditorCommand modelMenuActivation.
	self assert: activation class identicalTo: OPModelMenuActivation.

	exampleModel := OPBormExamples exampleDataFlows.
	mockDiagramController := Mock new.
	mockDiagramController stub model willReturn: exampleModel.
	mockEditor := Mock new.
	mockEditor stub diagramController willReturn: mockDiagramController.

	command := OPBormDslEditorCommand new.
	command instVarNamed: #editor put: mockEditor.
	commandWindow := command execute.
	[
		self assert: commandWindow presenter class identicalTo: OPDslEditor.
		self assert: commandWindow presenter model identicalTo: exampleModel.
		self assert: commandWindow presenter editor text asString equals: (BormLangSerializer export: exampleModel) ] ensure: [
		commandWindow close ]
]

{ #category : 'tests' }
OPDslEditorTest >> testUpdateFromModelSerializesAndHighlightsText [

	| exampleModel expectedSource highlightedText |
	dslEditor := self newConfiguredEditor.
	dslEditor updateFromModel.
	self assert: dslEditor editor text equals: ''.

	exampleModel := OPBormExamples exampleDataFlows.
	expectedSource := BormLangSerializer export: exampleModel.
	dslEditor model: exampleModel.
	dslEditor autoUpdate click.

	highlightedText := dslEditor editor text.
	self assert: highlightedText class identicalTo: Text.
	self assert: highlightedText asString equals: expectedSource.
	self assertCollection: (self colorsAt: 1 in: highlightedText) includesAll: { Color blue }.
	self
		assertCollection: (self colorsAt: (expectedSource indexOfSubCollection: '"User"') in: highlightedText)
		includesAll: { Color green muchDarker darker }
]

{ #category : 'tests' }
OPDslEditorTest >> testUpdateModelColorsInvalidLineRedOnSingleMiddleAndLastLineWithoutReplacingModel [

	| targetModel announcedEvents middleLineSource lastLineSource |
	dslEditor := self newConfiguredEditor.
	targetModel := BormORModel named: 'Existing'.
	targetModel add: (BormParticipant named: 'Original').
	dslEditor model: targetModel.

	announcedEvents := OrderedCollection new.
	targetModel announcer when: OPModelContentReplaced do: [ :eachEvent | announcedEvents add: eachEvent ] for: self.

	dslEditor editor text: 'UnknownType "Broken" {}'.
	dslEditor updateModel.
	self assert: (targetModel participants collect: #name as: Array) equals: #( 'Original' ).
	self assertEmpty: announcedEvents.
	self assertCollection: (self colorsAt: 1 in: dslEditor editor text) includesAll: { Color red }.

	middleLineSource := 'Person "Customer" {
	invalidStatement
}'.
	dslEditor editor text: middleLineSource.
	dslEditor updateModel.
	self assert: (targetModel participants collect: #name as: Array) equals: #( 'Original' ).
	self assertEmpty: announcedEvents.
	self denyCollection: (self colorsAt: 1 in: dslEditor editor text) includesAny: { Color red }.
	self
		assertCollection: (self colorsAt: (middleLineSource indexOfSubCollection: 'invalidStatement') in: dslEditor editor text)
		includesAll: { Color red }.
	self denyCollection: (self colorsAt: middleLineSource size in: dslEditor editor text) includesAny: { Color red }.

	lastLineSource := 'Person "Customer" {
	invalidLastLine'.
	dslEditor editor text: lastLineSource.
	dslEditor updateModel.
	self denyCollection: (self colorsAt: 1 in: dslEditor editor text) includesAny: { Color red }.
	self assertCollection: (self colorsAt: lastLineSource size in: dslEditor editor text) includesAll: { Color red }
]

{ #category : 'tests' }
OPDslEditorTest >> testUpdateModelReplacesElementsAndAnnouncesContentReplaced [

	| initialModel announcedEvents |
	dslEditor := self newConfiguredEditor.
	dslEditor editor text: 'Person "Customer" {
	initial state "Start"
}'.
	dslEditor updateModel.

	initialModel := dslEditor model.
	self assert: initialModel class identicalTo: BormORModel.
	self assert: (initialModel participants collect: #name as: Array) equals: #( 'Customer' ).

	announcedEvents := OrderedCollection new.
	initialModel announcer when: OPModelContentReplaced do: [ :eachEvent | announcedEvents add: eachEvent ] for: self.

	dslEditor editor text: 'System "Backend" {
	final state "Done"
}'.
	dslEditor updateModel.

	self assert: dslEditor model identicalTo: initialModel.
	self assert: (initialModel participants collect: #name as: Array) equals: #( 'Backend' ).
	self assert: announcedEvents size equals: 1.
	self assert: announcedEvents first model identicalTo: initialModel.
	self assertCollection: (self colorsAt: 1 in: dslEditor editor text) includesAll: { Color blue }
]
