Class {
	#name : 'OPBormContainerControllerTest',
	#superclass : 'OPBormControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'testing' }
OPBormContainerControllerTest class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ self = OPBormContainerControllerTest
]

{ #category : 'accessing' }
OPBormContainerControllerTest >> testFigureRefresh [

	| text |
	controller createModelIn: diagramController model.
	diagramController addController: controller.
	controller
		createDiagramElement;
		renderDiagramElement.
	self assert:
		(controller roassalShape propertyAt: #RSLabeled) text = ''.
	controller model name: 'new name'.
	controller diagramElement modelChanged.
	text := (controller roassalShape propertyAt: #RSLabeled) text.
	self assert:
		((text last: 8) = 'new name' or: [ (text first: 8) = 'new name' ])
]
