"
A BormCommunicationControllerTest is a test class for testing the behavior of BormCommunicationController
"
Class {
	#name : 'OPBormCommunicationControllerTest',
	#superclass : 'OPBormRelationshipControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

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

{ #category : 'accessing' }
OPBormCommunicationControllerTest >> controllerClass [
	^ OPBormCommunicationController
]

{ #category : 'accessing' }
OPBormCommunicationControllerTest >> diagramElementClass [

	^ BormCommunicationShape
]

{ #category : 'accessing' }
OPBormCommunicationControllerTest >> modelClass [
	^ BormCommunication
]

{ #category : 'as yet unclassified' }
OPBormCommunicationControllerTest >> sourceControllerClass [
	^ OPBormActivityController
]

{ #category : 'as yet unclassified' }
OPBormCommunicationControllerTest >> sourceModelClass [

	^ BormActivity
]
