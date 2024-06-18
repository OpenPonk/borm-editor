"
A BormDataFlowControllerTest is a test class for testing the behavior of BormDataFlowController
"
Class {
	#name : 'OPBormDataFlowControllerTest',
	#superclass : 'OPBormAssociationEnhancementControllerTest',
	#instVars : [
		'communication',
		'communicationController'
	],
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPBormDataFlowControllerTest >> controllerClass [
	^ OPBormDataFlowController
]

{ #category : 'accessing' }
OPBormDataFlowControllerTest >> diagramElementClass [

	^ BormDataFlowShape
]

{ #category : 'accessing' }
OPBormDataFlowControllerTest >> modelClass [
	^ BormDataFlow
]

{ #category : 'as yet unclassified' }
OPBormDataFlowControllerTest >> modelOwner [
	^ communication
]

{ #category : 'running' }
OPBormDataFlowControllerTest >> setUp [
	super setUp.
	communicationController := OPBormCommunicationController new.
	communication := BormCommunication new.
	communicationController model: communication.
	diagramController addController: communicationController
]

{ #category : 'accessing' }
OPBormDataFlowControllerTest >> targetControllerClass [
	^ OPBormCommunicationController
]

{ #category : 'accessing' }
OPBormDataFlowControllerTest >> targetModelClass [
	^ BormCommunication
]

{ #category : 'running' }
OPBormDataFlowControllerTest >> targetsSourceControllerClass [

	^ OPBormActivityController
]
