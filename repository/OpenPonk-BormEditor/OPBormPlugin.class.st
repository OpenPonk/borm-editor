"
I am a descriptior class for Borm plugin.
"
Class {
	#name : 'OPBormPlugin',
	#superclass : 'OPPlugin',
	#category : 'OpenPonk-BormEditor-Adapters',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Adapters'
}

{ #category : 'toolbar' }
OPBormPlugin class >> toolbarMenu: aBuilder [

	<opEditorToolbarMenu: #OPBormPlugin>
	(aBuilder item: 'DSL Editor')
		icon: OPBormEditorIcons oRModel16Icon;
		action: [ 
			OPDslEditor new
				parser: BormLangParser new;
				exporter: BormLangSerializer new;
				highlighter: BormLangHighlighter new;
				modelClass: BormORModel;
				model: aBuilder model diagramController model;
				openWithSpec ]
]

{ #category : 'accessing' }
OPBormPlugin >> diagramControllerClass [
	^ OPBormDiagramController
]

{ #category : 'accessing' }
OPBormPlugin >> icon [
	^ OPBormEditorIcons oRModel16Icon
]

{ #category : 'as yet unclassified' }
OPBormPlugin >> layouterClass [
	^ OPBormLayouter
]

{ #category : 'accessing' }
OPBormPlugin >> modelClass [
	^ BormORModel
]

{ #category : 'accessing' }
OPBormPlugin >> modelSerializerClass [
	^ OPStonModelSerializer
]

{ #category : 'accessing' }
OPBormPlugin >> name [
	^ 'Borm OR Diagram'
]

{ #category : 'as yet unclassified' }
OPBormPlugin >> supportsHidingElements [
	^ true
]
