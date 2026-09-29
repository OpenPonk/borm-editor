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

{ #category : 'accessing' }
OPBormPlugin class >> repositoryName [
	^ #'borm-editor'
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
			   modelFactory: [ OPBormExamples examplePizzaDelivery ]
			   isExample: true).
		  (OPProjectTemplate
			   named: 'Traveling Card'
			   icon: self icon
			   modelFactory: [ OPBormExamples exampleTravelingCard ]
			   isExample: true).
		  (OPProjectTemplate
			   named: 'Data Flows'
			   icon: self icon
			   modelFactory: [ OPBormExamples exampleDataFlows ]
			   isExample: true).
		  (OPProjectTemplate
			   named: 'Loan Approval'
			   icon: self icon
			   modelFactory: [ OPBormExamples exampleLoanApproval ]
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
