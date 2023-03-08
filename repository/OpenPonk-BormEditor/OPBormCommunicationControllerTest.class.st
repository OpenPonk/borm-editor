"
A BormCommunicationControllerTest is a test class for testing the behavior of BormCommunicationController
"
Class {
	#name : #OPBormCommunicationControllerTest,
	#superclass : #OPBormRelationshipControllerTest,
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #accessing }
OPBormCommunicationControllerTest >> controllerClass [
	^ OPBormCommunicationController
]

{ #category : #accessing }
OPBormCommunicationControllerTest >> diagramElementClass [
	^ RTEdge
]

{ #category : #accessing }
OPBormCommunicationControllerTest >> modelClass [
	^ BormCommunication
]

{ #category : #'as yet unclassified' }
OPBormCommunicationControllerTest >> targetControllerClass [
	^ OPBormActivityController
]
