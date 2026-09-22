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

{ #category : 'toolbar menu' }
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
				open ]
]

{ #category : 'accessing' }
OPBormPlugin >> diagramControllerClass [
	^ OPBormDiagramController
]

{ #category : 'templates' }
OPBormPlugin >> exampleProjectTemplates [
	"Answers example project templates for BORM OR diagrams."

	^ { 
		(OPProjectTemplate
			named: 'Pizza Delivery'
			icon: self icon
			modelFactory: [ OPBormExampleDiagrams examplePizzaDelivery ]
			isExample: true).
		(OPProjectTemplate
			named: 'Traveling Card'
			icon: self icon
			modelFactory: [ OPBormExampleDiagrams exampleTravelingCard ]
			isExample: true).
		(OPProjectTemplate
			named: 'Data Flows'
			icon: self icon
			modelFactory: [ OPBormExampleDiagrams exampleDataFlows ]
			isExample: true) }
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
