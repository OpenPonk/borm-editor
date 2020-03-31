Class {
	#name : #OPBormParticipantControllerTest,
	#superclass : #OPBormContainerControllerTest,
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #accessing }
OPBormParticipantControllerTest >> controllerClass [
	^ OPBormParticipantController
]

{ #category : #accessing }
OPBormParticipantControllerTest >> createTargetController [
	^ diagramController
]

{ #category : #accessing }
OPBormParticipantControllerTest >> createTargetModel [
	^ diagramController model
]

{ #category : #accessing }
OPBormParticipantControllerTest >> figureClass [
	^ RTElement
]

{ #category : #accessing }
OPBormParticipantControllerTest >> modelClass [
	^ BormParticipant
]

{ #category : #running }
OPBormParticipantControllerTest >> setUpTarget [
	targetController := diagramController
]

{ #category : #accessing }
OPBormParticipantControllerTest >> targetControllerClass [
	^ self diagramControllerClass
]

{ #category : #accessing }
OPBormParticipantControllerTest >> targetModelClass [
	^ self diagramModelClass
]
