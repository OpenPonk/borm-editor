"
I am the controller for BORM Participants. I manage canvas interactions, connection targeting rules, and handle the rendering hooks for the participant's nested process nodes.
"
Class {
	#name : 'OPBormParticipantController',
	#superclass : 'OPBormElementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPBormParticipantController class >> diagramElementClass [

	^ BormParticipantShape
]

{ #category : 'accessing' }
OPBormParticipantController class >> viewModelClass [
	^ OPBormParticipantViewModel
]

{ #category : 'connecting' }
OPBormParticipantController >> canBeTargetFor: aController [
	^ aController isKindOf: OPBormProcessNodeController
]
