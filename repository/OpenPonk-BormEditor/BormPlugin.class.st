"
I am a descriptior class for Borm plugin.
"
Class {
	#name : #BormPlugin,
	#superclass : #OPPlugin,
	#category : #'OpenPonk-BormEditor-Adapters'
}

{ #category : #toolbar }
BormPlugin class >> canvasToolbarFor: aBuilder [
	<opCanvasToolbar: #BormPlugin>
	(aBuilder item: 'Layout')
		action: [ aBuilder model diagramController applyDefaultLayout ]
]

{ #category : #toolbar }
BormPlugin class >> toolbarMenu: aBuilder [
	<opEditorToolbarMenu: #BormPlugin>
	(aBuilder item: 'DSL Editor')
		action: [ OPDslEditor new
				parser: BormLangParser new;
				exporter: BormLangSerializer new;
				highlighter: BormLangHighlighter new;
				modelClass: BormORModel;
				model: aBuilder model diagramController model;
				openWithSpec ]
]

{ #category : #accessing }
BormPlugin >> diagramControllerClass [
	^ BormDiagramController
]

{ #category : #accessing }
BormPlugin >> icon [
	^ BormEditorIcons current oRModel16Icon
]

{ #category : #accessing }
BormPlugin >> modelClass [
	^ BormORModel
]

{ #category : #accessing }
BormPlugin >> name [
	^ 'Borm OR Diagram'
]

{ #category : #accessing }
BormPlugin >> serializerClass [
	^ OPStonSerializer
]
