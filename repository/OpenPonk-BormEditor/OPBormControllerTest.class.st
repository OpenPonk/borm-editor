Class {
	#name : #OPBormControllerTest,
	#superclass : #OPControllerTest,
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #testing }
OPBormControllerTest class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ self = OPBormControllerTest
]

{ #category : #accessing }
OPBormControllerTest >> controllerClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
OPBormControllerTest >> diagramModelClass [
	^ BormORModel
]

{ #category : #accessing }
OPBormControllerTest >> figureClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
OPBormControllerTest >> modelClass [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
OPBormControllerTest >> modelOwner [
	^ diagramController model
]

{ #category : #accessing }
OPBormControllerTest >> testClassSideModelClass [
	self assert: self controllerClass modelClass equals: self modelClass
]

{ #category : #accessing }
OPBormControllerTest >> testCreateController [
	self assert: controller class = self controllerClass
]

{ #category : #accessing }
OPBormControllerTest >> testCreateModel [
	controller createModelIn: diagramController model.
	self assert: controller model class equals: self modelClass
]

{ #category : #accessing }
OPBormControllerTest >> testModelClass [
	self assert: controller modelClass equals: self modelClass
]
