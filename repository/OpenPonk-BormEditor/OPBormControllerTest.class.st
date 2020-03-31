Class {
	#name : #OPBormControllerTest,
	#superclass : #OPControllerTest,
	#instVars : [
		'targetController'
	],
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

{ #category : #running }
OPBormControllerTest >> createTargetController [
	^ self targetControllerClass new
		model: self createTargetModel;
		yourself
]

{ #category : #running }
OPBormControllerTest >> createTargetModel [
	^ self targetModelClass new
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

{ #category : #accessing }
OPBormControllerTest >> modelOwner [
	^ diagramController model
]

{ #category : #running }
OPBormControllerTest >> setUp [
	super setUp.
	self setUpTarget
]

{ #category : #running }
OPBormControllerTest >> setUpTarget [
	targetController := self targetControllerClass new.
	targetController diagramController: diagramController.
	targetController createModelIn: diagramController model
]

{ #category : #accessing }
OPBormControllerTest >> targetControllerClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
OPBormControllerTest >> targetModelClass [
	^ self subclassResponsibility
]

{ #category : #tests }
OPBormControllerTest >> testAssignmentToParent [
	controller createModelIn: targetController model.
	self assert: (targetController model has: controller model)
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
	controller createModelIn: targetController model.
	self assert: controller model class equals: self modelClass
]

{ #category : #accessing }
OPBormControllerTest >> testModelClass [
	self assert: controller modelClass equals: self modelClass
]
