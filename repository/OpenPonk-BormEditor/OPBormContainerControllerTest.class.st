Class {
	#name : #OPBormContainerControllerTest,
	#superclass : #OPBormControllerTest,
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #testing }
OPBormContainerControllerTest class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ self = OPBormContainerControllerTest
]

{ #category : #accessing }
OPBormContainerControllerTest >> testClassSideModelClass [
	self assert: self controllerClass modelClass equals: self modelClass
]

{ #category : #accessing }
OPBormContainerControllerTest >> testCreateFigure [
	controller createModelIn: diagramController model.
	diagramController addController: controller.
	controller renderFigureIn: diagramController view.
	self assert: controller figure class = RTElement
]

{ #category : #accessing }
OPBormContainerControllerTest >> testCreateModel [
	self assert: (controller createModelIn: diagramController model) class = self modelClass
]

{ #category : #accessing }
OPBormContainerControllerTest >> testFigureRefresh [
	| text |
	controller createModelIn: diagramController model.
	diagramController addController: controller.
	controller renderFigureIn: diagramController view.
	self assert: (controller figure attributeAt: #RTLabelledLabel) text = ''.
	controller model name: 'new name'.
	controller refreshFigure.
	text := (controller figure attributeAt: #RTLabelledLabel) text.
	self assert: ((text last: 8) = 'new name' or: [ (text first: 8) = 'new name' ])
]
