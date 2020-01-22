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
