"
I am a unit test class verifying the instantiation, canvas rendering, and transition connection targeting logic of OPBormStateController.
"
Class {
	#name : 'OPBormStateControllerTest',
	#superclass : 'OPBormProcessNodeControllerTest',
	#category : 'OpenPonk-BormEditor-Tests-Controllers',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Controllers'
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

{ #category : 'tests' }
OPBormStateControllerTest >> testCanBeTargetForTransitionFromActivityOnly [

	| transitionFromActivity transitionFromState communication |
	transitionFromActivity := OPBormTransitionController new
		                          source: OPBormActivityController new;
		                          yourself.
	transitionFromState := OPBormTransitionController new
		                       source: OPBormStateController new;
		                       yourself.
	communication := OPBormCommunicationController new
		                 source: OPBormActivityController new;
		                 yourself.

	self
		assert: (controller canBeTargetFor: transitionFromActivity)
		description: 'State controller must accept transition from activity'.
	self deny: (controller canBeTargetFor: transitionFromState) description: 'State controller must reject transition from state'.
	self deny: (controller canBeTargetFor: communication) description: 'State controller must reject communication'
]
