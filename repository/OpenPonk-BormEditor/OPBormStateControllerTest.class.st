"
A BormStateControllerTest is a test class for testing the behavior of BormStateController
"
Class {
	#name : 'OPBormStateControllerTest',
	#superclass : 'OPBormControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPBormStateControllerTest >> controllerClass [
	^ OPBormStateController
]

{ #category : 'accessing' }
OPBormStateControllerTest >> diagramElementClass [
	^ BormStateShape
]

{ #category : 'accessing' }
OPBormStateControllerTest >> modelClass [
	^ BormState
]

{ #category : 'accessing' }
OPBormStateControllerTest >> targetControllerClass [
	^ OPBormParticipantController
]

{ #category : 'accessing' }
OPBormStateControllerTest >> targetModelClass [
	^ BormParticipant
]
