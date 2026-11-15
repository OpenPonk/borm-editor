"
Spec presenter acting as a text-based Domain-Specific Language (DSL) editor. 
Integrates a parser, syntax highlighter, and automatic model updating mechanism to support text-to-model workflows.
"
Class {
	#name : 'OPDslEditor',
	#superclass : 'SpPresenter',
	#instVars : [
		'editor',
		'autoUpdate',
		'toolbar',
		'location',
		'model',
		'parser',
		'exporter',
		'modelClass',
		'highlighter'
	],
	#category : 'OpenPonk-BormEditor-Dsl',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Dsl'
}

{ #category : 'layout' }
OPDslEditor class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #toolbar expand: false;
		  add: #editor;
		  add: #autoUpdate expand: false;
		  yourself
]

{ #category : 'accessing - spec' }
OPDslEditor >> autoUpdate [
	^ autoUpdate
]

{ #category : 'initialization' }
OPDslEditor >> buildToolbar: aMenu [

	aMenu addGroup: [ :group |
			group
				addItem: [ :item |
						item
							name: 'New';
							description: 'New Diagram';
							icon: (self iconNamed: #add);
							action: [ self newConfiguredEditor open ] ];
				addItem: [ :item |
						item
							name: 'Save';
							description: 'Save Diagram';
							icon: (self iconNamed: #smallSave);
							action: [ self saveToFile: location ] ];
				addItem: [ :item |
						item
							name: 'Save as...';
							description: 'Save Diagram As...';
							icon: (self iconNamed: #smallSave);
							action: [ self saveToFile: nil ] ];
				addItem: [ :item |
						item
							name: 'Open';
							description: 'Open...';
							icon: (self iconNamed: #open);
							action: [ self openFromFile ] ];
				addItem: [ :item |
						item
							name: 'Open Editor';
							description: 'Open Editor';
							icon: (self iconNamed: #open);
							action: [ self openModelInWorkbench ] ] ]
]

{ #category : 'initialization' }
OPDslEditor >> connectPresenters [

	super connectPresenters.
	editor whenSubmitDo: [ :submittedText | self textUpdated: submittedText ]
]

{ #category : 'accessing - spec' }
OPDslEditor >> editor [
	^ editor
]

{ #category : 'accessing' }
OPDslEditor >> exporter [
	^ exporter
]

{ #category : 'accessing' }
OPDslEditor >> exporter: anExporter [
	exporter := anExporter
]

{ #category : 'accessing - spec' }
OPDslEditor >> highlight: aText [

	| text parsed |
	text := aText asText.
	highlighter ifNil: [ ^ text ].
	parsed := highlighter parse: text.
	parsed isPetitFailure ifTrue: [ ^ text ].
	parsed flattened select: [ :each | each isAssociation ] thenDo: [ :each |
			(each key isAssociation and: [ each value isAssociation ])
				ifTrue: [
						text makeColor: each key value from: each key key start to: each key key stop.
						text makeColor: each value value from: each value key start to: each value key stop ]
				ifFalse: [ text makeColor: each value from: each key start to: each key stop ] ].
	^ text
]

{ #category : 'accessing' }
OPDslEditor >> highlighter [

	^ highlighter
]

{ #category : 'accessing - spec' }
OPDslEditor >> highlighter: aHighlighterParser [
	highlighter := aHighlighterParser
]

{ #category : 'initialization' }
OPDslEditor >> initializePresenters [

	toolbar := self newMenuBar.
	self buildToolbar: toolbar.
	(editor := self newText) whenBuiltDo: [ :builtAdapter | builtAdapter widget withLineNumbers ].
	(autoUpdate := self newButton)
		label: 'Refresh from Model';
		action: [ self updateFromModel ].
	self focusOrder
		add: editor;
		add: autoUpdate
]

{ #category : 'initialization' }
OPDslEditor >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: self title
]

{ #category : 'accessing' }
OPDslEditor >> location [

	^ location
]

{ #category : 'accessing' }
OPDslEditor >> model [

	^ model
]

{ #category : 'accessing' }
OPDslEditor >> model: aModel [
	model := aModel
]

{ #category : 'accessing' }
OPDslEditor >> modelClass [
	^ modelClass
]

{ #category : 'accessing' }
OPDslEditor >> modelClass: aModelClass [
	modelClass := aModelClass
]

{ #category : 'instance creation' }
OPDslEditor >> newConfiguredEditor [

	^ self class new
		  parser: (self parser ifNotNil: [ :activeParser | activeParser class new ]);
		  exporter: (self exporter ifNotNil: [ :activeExporter | activeExporter class new ]);
		  highlighter: (self highlighter ifNotNil: [ :activeHighlighter | activeHighlighter class new ]);
		  modelClass: self modelClass;
		  yourself
]

{ #category : 'instance creation' }
OPDslEditor >> newModel [
	^ self modelClass new
]

{ #category : 'save/load' }
OPDslEditor >> openFromFile [

	StOpenFilePresenter new
		title: 'Choose a .txt file';
		extensions: #( 'txt' ) named: 'Text files';
		okAction: [ :selectedFile |
				selectedFile ifNotNil: [
							| text |
							location := selectedFile.
							text := location contents asText.
							self highlight: text.
							editor text: text ] ];
		open
]

{ #category : 'event handling' }
OPDslEditor >> openModelInWorkbench [

	model ifNil: [ self updateModel ].
	^ OPWorkbench openModel: model
]

{ #category : 'accessing' }
OPDslEditor >> parser [
	^ parser
]

{ #category : 'accessing' }
OPDslEditor >> parser: aParser [
	parser := aParser
]

{ #category : 'save/load' }
OPDslEditor >> saveToFile: aPath [

	aPath ifNil: [
			StSaveFilePresenter new
				title: 'Save to .txt file';
				extensions: #( 'txt' ) named: 'Text files';
				okAction: [ :selectedFile | selectedFile ifNotNil: [ self saveToFile: selectedFile ] ];
				openModal.
			^ self ].
	location := aPath.
	location ensureDelete.
	location writeStreamDo: [ :stream | stream nextPutAll: editor text asString ].
	self updateModel
]

{ #category : 'event handling' }
OPDslEditor >> textUpdated: aString [
	location ifNil: [ self updateModel ] ifNotNil: [ self saveToFile: location ]
]

{ #category : 'accessing - deprecated' }
OPDslEditor >> title [

	^ 'DSL Editor'
]

{ #category : 'accessing - spec' }
OPDslEditor >> toolbar [
	^ toolbar
]

{ #category : 'event handling' }
OPDslEditor >> updateFromModel [
	| text |
	model ifNil: [ ^ self ].
	text := (self exporter export: model) asText.
	self highlight: text.
	editor text: text
]

{ #category : 'event handling' }
OPDslEditor >> updateModel [

	| statements text |
	model ifNil: [ model := self newModel ].
	text := editor text asText.
	text makeAllColor: self theme textColor.
	statements := self parser class new parseStatements: text asString.
	statements isPetitFailure
		ifTrue: [
				text ifNotEmpty: [
						| errorPosition |
						errorPosition := statements position + 1 min: text size.
						text asString lineIndicesDo: [ :start :endWithoutDelimiters :end |
							(errorPosition between: start and: end) ifTrue: [ text makeColor: Color red from: start to: end ] ] ] ]
		ifFalse: [
				parser replaceModel: model withStatements: statements.
				self highlight: text.
				model announcer announce: (OPModelContentReplaced model: model) ].
	editor text: text
]
