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

{ #category : 'initialization' }
OPBormTransitionControllerTest >> assignModelSource [

	super assignModelSource.
	model source addTransition: model
]

{ #category : 'initialization' }
OPBormTransitionControllerTest >> assignModelTarget [

	super assignModelTarget.
	model target addTransition: model
]

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
OPBormTransitionControllerTest >> sourceControllerClass [
	^ OPBormStateController
]

{ #category : 'as yet unclassified' }
OPBormTransitionControllerTest >> sourceModelClass [
	^ BormState
]

{ #category : 'as yet unclassified' }
OPBormTransitionControllerTest >> targetControllerClass [
	^ OPBormActivityController
]

{ #category : 'as yet unclassified' }
OPBormTransitionControllerTest >> targetModelClass [
	^ BormActivity
]
