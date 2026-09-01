"
I am a unit test class verifying the behavior of OPBormParticipantController, focusing on its role as a container, diagram hooks, and figure rendering tasks.
"
Class {
	#name : 'OPBormParticipantControllerTest',
	#superclass : 'OPBormContainerControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'constants' }
OPBormParticipantControllerTest class >> diagramElementClass [

	^ BormParticipantShape
]

{ #category : 'constants' }
OPBormParticipantControllerTest >> controllerClass [
	^ OPBormParticipantController
]

{ #category : 'accessing' }
OPBormParticipantControllerTest >> createTargetController [
	^ diagramController
]

{ #category : 'constants' }
OPBormParticipantControllerTest >> creationTargetControllerClass [
	^ self diagramControllerClass
]

{ #category : 'constants' }
OPBormParticipantControllerTest >> creationTargetModelClass [
	^ self diagramModelClass
]

{ #category : 'constants' }
OPBormParticipantControllerTest >> modelClass [
	^ BormParticipant
]
