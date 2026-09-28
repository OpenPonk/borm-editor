"
A model command that opens the text-based DSL editor for the active BORM diagram.
"
Class {
	#name : 'OPBormDslEditorCommand',
	#superclass : 'OPBormCommand',
	#category : 'OpenPonk-BormEditor-Commands',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Commands'
}

{ #category : 'activation' }
OPBormDslEditorCommand class >> modelMenuActivation [
	<classAnnotation>
	^ OPModelMenuActivation
		byItemOf: OPModelBasicMenuGroup
		order: 20
		for: OPEditor
]

{ #category : 'accessing' }
OPBormDslEditorCommand >> defaultMenuIcon [
	"Answers the icon form for the DSL editor command."
	^ OPBormEditorIcons oRModel16Icon
]

{ #category : 'accessing' }
OPBormDslEditorCommand >> defaultMenuItemName [
	"Answers the display name of the DSL editor command."
	^ 'DSL Editor'
]

{ #category : 'execution' }
OPBormDslEditorCommand >> execute [
	"Opens the BORM DSL editor on the active domain model."
	OPDslEditor new
		parser: BormLangParser new;
		exporter: BormLangSerializer new;
		highlighter: BormLangHighlighter new;
		modelClass: BormORModel;
		model: self model;
		open
]
