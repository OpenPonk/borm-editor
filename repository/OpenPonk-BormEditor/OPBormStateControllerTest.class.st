"
I am a unit test class verifying the instantiation, canvas rendering, and transition connection targeting logic of OPBormStateController.
"
Class {
	#name : 'OPBormStateControllerTest',
	#superclass : 'OPBormProcessNodeControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'constants' }
OPBormStateControllerTest class >> diagramElementClass [
	^ BormStateShape
]

{ #category : 'constants' }
OPBormStateControllerTest >> controllerClass [
	^ OPBormStateController
]

{ #category : 'constants' }
OPBormStateControllerTest >> creationTargetControllerClass [
	^ OPBormParticipantController
]

{ #category : 'constants' }
OPBormStateControllerTest >> creationTargetModelClass [
	^ BormParticipant
]

{ #category : 'constants' }
OPBormStateControllerTest >> modelClass [
	^ BormState
]
