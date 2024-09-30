"
A BormStateControllerTest is a test class for testing the behavior of BormStateController
"
Class {
	#name : 'OPBormStateControllerTest',
	#superclass : 'OPBormProcessNodeControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPBormStateControllerTest >> controllerClass [
	^ OPBormStateController
]

{ #category : 'accessing' }
OPBormStateControllerTest >> creationTargetControllerClass [
	^ OPBormParticipantController
]

{ #category : 'accessing' }
OPBormStateControllerTest >> creationTargetModelClass [
	^ BormParticipant
]

{ #category : 'accessing' }
OPBormStateControllerTest >> diagramElementClass [
	^ BormStateShape
]

{ #category : 'accessing' }
OPBormStateControllerTest >> modelClass [
	^ BormState
]
