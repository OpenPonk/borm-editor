"
I am a unit test class verifying the behavior of OPBormCommunicationController, ensuring correct cross-participant source and target edge assignments.
"
Class {
	#name : 'OPBormCommunicationControllerTest',
	#superclass : 'OPBormRelationshipControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'constants' }
OPBormCommunicationControllerTest class >> diagramElementClass [

	^ BormCommunicationShape
]

{ #category : 'initialization' }
OPBormCommunicationControllerTest >> assignModelSource [

	super assignModelSource.
	model source send: model
]

{ #category : 'initialization' }
OPBormCommunicationControllerTest >> assignModelTarget [

	super assignModelTarget.
	model target receive: model
]

{ #category : 'constants' }
OPBormCommunicationControllerTest >> controllerClass [
	^ OPBormCommunicationController
]

{ #category : 'constants' }
OPBormCommunicationControllerTest >> modelClass [
	^ BormCommunication
]

{ #category : 'constants' }
OPBormCommunicationControllerTest >> sourceControllerClass [
	^ OPBormActivityController
]

{ #category : 'constants' }
OPBormCommunicationControllerTest >> sourceModelClass [

	^ BormActivity
]
