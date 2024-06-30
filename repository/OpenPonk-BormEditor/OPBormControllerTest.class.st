Class {
	#name : 'OPBormControllerTest',
	#superclass : 'OPAbstractElementControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'testing' }
OPBormControllerTest class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ self = OPBormControllerTest
]

{ #category : 'accessing' }
OPBormControllerTest >> creationTargetControllerClass [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
OPBormControllerTest >> creationTargetModelClass [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
OPBormControllerTest >> diagramControllerClass [

	^ OPBormDiagramController
]

{ #category : 'accessing' }
OPBormControllerTest >> diagramModelClass [
	^ BormORModel
]

{ #category : 'running' }
OPBormControllerTest >> setUp [
	super setUp.
	self setUpCreationTarget
]

{ #category : 'running' }
OPBormControllerTest >> setUpCreationTarget [
	relationshipController := self creationTargetControllerClass new.
	relationshipController diagramController: diagramController.
	relationshipController createModelIn: diagramController model
]

{ #category : 'tests' }
OPBormControllerTest >> testAssignmentToParent [
	controller createModelIn: relationshipController model.
	self assert: (relationshipController model has: controller model)
]

{ #category : 'accessing' }
OPBormControllerTest >> testCreateModel [
	controller createModelIn: relationshipController model.
	self assert: controller model class equals: self modelClass
]
