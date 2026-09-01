"
I am the controller for BORM Activities. I manage diagram interactions and enforce valid connection rules for transitions and communications.
"
Class {
	#name : 'OPBormActivityController',
	#superclass : 'OPBormProcessNodeController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPBormActivityController class >> diagramElementClass [

	^ BormActivityShape
]

{ #category : 'accessing' }
OPBormActivityController class >> viewModelClass [
	^ OPBormActivityViewModel
]

{ #category : 'connecting' }
OPBormActivityController >> canBeSourceFor: aController [
	^ (aController isKindOf: OPBormTransitionController) | (aController isKindOf: OPBormCommunicationController)
]

{ #category : 'connecting' }
OPBormActivityController >> canBeTargetFor: aController [
	^ ((aController isKindOf: OPBormTransitionController) and: [ aController source isKindOf: OPBormStateController ])
		| ((aController isKindOf: OPBormCommunicationController) and: [ aController source model owner ~= self model owner ])
]
