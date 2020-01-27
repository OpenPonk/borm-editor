"
I am a descriptior class for Borm plugin.
"
Class {
	#name : #OPBormPlugin,
	#superclass : #OPPlugin,
	#category : #'OpenPonk-BormEditor-Adapters'
}

{ #category : #toolbar }
OPBormPlugin class >> canvasToolbarFor: aBuilder [
	<opCanvasToolbar: #OPBormPlugin>
	(aBuilder item: 'Layout')
		action: [ aBuilder model diagramController applyDefaultLayout ]
]

{ #category : #toolbar }
OPBormPlugin class >> toolbarMenu: aBuilder [
	<opEditorToolbarMenu: #OPBormPlugin>
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
OPBormPlugin >> diagramControllerClass [
	^ OPBormDiagramController
]

{ #category : #accessing }
OPBormPlugin >> icon [
	^ OPBormEditorIcons current oRModel16Icon
]

{ #category : #accessing }
OPBormPlugin >> modelClass [
	^ BormORModel
]

{ #category : #accessing }
OPBormPlugin >> name [
	^ 'Borm OR Diagram'
]

{ #category : #accessing }
OPBormPlugin >> serializerClass [
	^ OPStonSerializer
]

{ #category : #'as yet unclassified' }
OPBormPlugin >> supportsHidingElements [
	^ true
]
