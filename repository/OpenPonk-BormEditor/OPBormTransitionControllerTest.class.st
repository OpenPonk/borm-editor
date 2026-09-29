"
I am a unit test class verifying the behavior of OPBormTransitionController, testing correct sequential flow connections between process nodes.
"
Class {
	#name : 'OPBormTransitionControllerTest',
	#superclass : 'OPBormRelationshipControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'constants' }
OPBormTransitionControllerTest class >> diagramElementClass [

	^ BormTransitionShape
]

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

{ #category : 'constants' }
OPBormTransitionControllerTest >> controllerClass [
	^ OPBormTransitionController
]

{ #category : 'constants' }
OPBormTransitionControllerTest >> modelClass [
	^ BormTransition
]

{ #category : 'constants' }
OPBormTransitionControllerTest >> sourceControllerClass [
	^ OPBormStateController
]

{ #category : 'constants' }
OPBormTransitionControllerTest >> sourceModelClass [
	^ BormState
]

{ #category : 'constants' }
OPBormTransitionControllerTest >> targetControllerClass [
	^ OPBormActivityController
]

{ #category : 'constants' }
OPBormTransitionControllerTest >> targetModelClass [
	^ BormActivity
]
