"
A BormActivityControllerTest is a test class for testing the behavior of BormActivityController
"
Class {
	#name : 'OPBormActivityControllerTest',
	#superclass : 'OPBormProcessNodeControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPBormActivityControllerTest >> controllerClass [
	^ OPBormActivityController
]

{ #category : 'accessing' }
OPBormActivityControllerTest >> creationTargetControllerClass [
	^ OPBormParticipantController
]

{ #category : 'accessing' }
OPBormActivityControllerTest >> creationTargetModelClass [
	^ BormParticipant
]

{ #category : 'accessing' }
OPBormActivityControllerTest >> diagramElementClass [
	^ BormActivityShape
]

{ #category : 'accessing' }
OPBormActivityControllerTest >> modelClass [
	^ BormActivity
]
