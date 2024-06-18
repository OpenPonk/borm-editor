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
OPBormParticipantControllerTest >> createTargetModel [
	^ diagramController model
]

{ #category : 'accessing' }
OPBormParticipantControllerTest >> diagramElementClass [

	^ BormParticipantShape
]

{ #category : 'accessing' }
OPBormParticipantControllerTest >> modelClass [
	^ BormParticipant
]

{ #category : 'running' }
OPBormParticipantControllerTest >> setUpTarget [
	relationshipController := diagramController
]

{ #category : 'accessing' }
OPBormParticipantControllerTest >> targetControllerClass [
	^ self diagramControllerClass
]

{ #category : 'accessing' }
OPBormParticipantControllerTest >> targetModelClass [
	^ self diagramModelClass
]
