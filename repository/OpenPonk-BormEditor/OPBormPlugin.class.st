"
I am the core plugin descriptor for the BORM editor in OpenPonk. I register the BORM model classes, diagram controllers, layouters, and default UI tools.
"
Class {
	#name : 'OPBormPlugin',
	#superclass : 'OPPlugin',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'toolbar' }
OPBormPlugin class >> toolbarMenu: aBuilder [

	<opEditorToolbarMenu: #OPBormPlugin>
	(aBuilder item: 'DSL Editor (not working)')
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

{ #category : 'accessing' }
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

{ #category : 'testing' }
OPBormPlugin >> supportsHidingElements [
	^ true
]
