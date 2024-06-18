"
A BormActivityControllerTest is a test class for testing the behavior of BormActivityController
"
Class {
	#name : 'OPBormActivityControllerTest',
	#superclass : 'OPBormControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPBormActivityControllerTest >> controllerClass [
	^ OPBormActivityController
]

{ #category : 'accessing' }
OPBormActivityControllerTest >> diagramElementClass [
	^ BormActivityShape
]

{ #category : 'accessing' }
OPBormActivityControllerTest >> modelClass [
	^ BormActivity
]

{ #category : 'accessing' }
OPBormActivityControllerTest >> targetControllerClass [
	^ OPBormParticipantController
]

{ #category : 'accessing' }
OPBormActivityControllerTest >> targetModelClass [
	^ BormParticipant
]
