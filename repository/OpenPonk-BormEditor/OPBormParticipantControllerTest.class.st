Class {
	#name : 'OPBormParticipantControllerTest',
	#superclass : 'OPBormContainerControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPBormParticipantControllerTest >> controllerClass [
	^ OPBormParticipantController
]

{ #category : 'accessing' }
OPBormParticipantControllerTest >> createTargetController [
	^ diagramController
]

{ #category : 'accessing' }
OPBormParticipantControllerTest >> creationTargetControllerClass [
	^ self diagramControllerClass
]

{ #category : 'accessing' }
OPBormParticipantControllerTest >> creationTargetModelClass [
	^ self diagramModelClass
]

{ #category : 'accessing' }
OPBormParticipantControllerTest >> diagramElementClass [

	^ BormParticipantShape
]

{ #category : 'accessing' }
OPBormParticipantControllerTest >> modelClass [
	^ BormParticipant
]
