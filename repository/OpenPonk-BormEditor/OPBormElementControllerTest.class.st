Class {
	#name : 'OPBormElementControllerTest',
	#superclass : 'OPAbstractElementControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'testing' }
OPBormElementControllerTest class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ self = OPBormElementControllerTest
]

{ #category : 'accessing' }
OPBormElementControllerTest >> creationTargetControllerClass [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
OPBormElementControllerTest >> creationTargetModelClass [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
OPBormElementControllerTest >> diagramControllerClass [

	^ OPBormDiagramController
]

{ #category : 'accessing' }
OPBormElementControllerTest >> diagramModelClass [
	^ BormORModel
]
