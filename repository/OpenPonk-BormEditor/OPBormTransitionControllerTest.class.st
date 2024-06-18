"
A BormTransitionControllerTest is a test class for testing the behavior of BormTransitionController
"
Class {
	#name : 'OPBormTransitionControllerTest',
	#superclass : 'OPBormRelationshipControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPBormTransitionControllerTest >> controllerClass [
	^ OPBormTransitionController
]

{ #category : 'accessing' }
OPBormTransitionControllerTest >> diagramElementClass [

	^ BormTransitionShape
]

{ #category : 'accessing' }
OPBormTransitionControllerTest >> modelClass [
	^ BormTransition
]

{ #category : 'as yet unclassified' }
OPBormTransitionControllerTest >> targetControllerClass [
	^ OPBormStateController
]
