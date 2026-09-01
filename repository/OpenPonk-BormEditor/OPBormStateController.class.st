"
I am the controller for BORM States. I manage diagram interactions and enforce valid connection rules for incoming and outgoing process transitions.
"
Class {
	#name : 'OPBormStateController',
	#superclass : 'OPBormProcessNodeController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPBormStateController class >> diagramElementClass [

	^ BormStateShape
]

{ #category : 'accessing' }
OPBormStateController class >> viewModelClass [
	^ OPBormStateViewModel
]

{ #category : 'connecting' }
OPBormStateController >> canBeSourceFor: aController [
	^ aController isKindOf: OPBormTransitionController
]

{ #category : 'connecting' }
OPBormStateController >> canBeTargetFor: aController [
	^ (aController isKindOf: OPBormTransitionController) and: [ aController source isKindOf: OPBormActivityController ]
]
