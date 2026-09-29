"
I am a unit test class verifying the instantiation, canvas rendering, and valid connection targeting logic of OPBormActivityController.
"
Class {
	#name : 'OPBormActivityControllerTest',
	#superclass : 'OPBormProcessNodeControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'constants' }
OPBormActivityControllerTest class >> diagramElementClass [
	^ BormActivityShape
]

{ #category : 'constants' }
OPBormActivityControllerTest >> controllerClass [
	^ OPBormActivityController
]

{ #category : 'constants' }
OPBormActivityControllerTest >> creationTargetControllerClass [
	^ OPBormParticipantController
]

{ #category : 'constants' }
OPBormActivityControllerTest >> creationTargetModelClass [
	^ BormParticipant
]

{ #category : 'constants' }
OPBormActivityControllerTest >> modelClass [
	^ BormActivity
]
