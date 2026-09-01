"
I am an abstract base test class verifying the instantiation, targeting behavior, and rendering setup for BORM diagram controllers.
"
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

{ #category : 'constants' }
OPBormElementControllerTest >> creationTargetControllerClass [
	^ self subclassResponsibility
]

{ #category : 'constants' }
OPBormElementControllerTest >> creationTargetModelClass [
	^ self subclassResponsibility
]

{ #category : 'constants' }
OPBormElementControllerTest >> diagramControllerClass [

	^ OPBormDiagramController
]

{ #category : 'constants' }
OPBormElementControllerTest >> diagramModelClass [
	^ BormORModel
]
