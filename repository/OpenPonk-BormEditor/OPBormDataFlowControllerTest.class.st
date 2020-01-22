"
A BormDataFlowControllerTest is a test class for testing the behavior of BormDataFlowController
"
Class {
	#name : #OPBormDataFlowControllerTest,
	#superclass : #OPBormControllerTest,
	#instVars : [
		'communication',
		'communicationController'
	],
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #accessing }
OPBormDataFlowControllerTest >> controllerClass [
	^ OPBormDataFlowController
]

{ #category : #accessing }
OPBormDataFlowControllerTest >> figureClass [
	^ RTElement
]

{ #category : #accessing }
OPBormDataFlowControllerTest >> modelClass [
	^ BormDataFlow
]

{ #category : #'as yet unclassified' }
OPBormDataFlowControllerTest >> modelOwner [
	^ communication
]

{ #category : #running }
OPBormDataFlowControllerTest >> setUp [
	super setUp.
	communicationController := OPBormCommunicationController new.
	communication := BormCommunication new.
	communicationController model: communication.
	diagramController addController: communicationController
]
