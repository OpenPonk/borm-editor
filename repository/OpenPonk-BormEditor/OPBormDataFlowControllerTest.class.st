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
