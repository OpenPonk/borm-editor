Class {
	#name : 'OPBormActivityController',
	#superclass : 'OPBormProcessNodeController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'testing' }
OPBormActivityController >> canBeSourceFor: aController [
	^ (aController isKindOf: OPBormTransitionController) | (aController isKindOf: OPBormCommunicationController)
]

{ #category : 'testing' }
OPBormActivityController >> canBeTargetFor: aController [
	^ ((aController isKindOf: OPBormTransitionController) and: [ aController source isKindOf: OPBormStateController ])
		| ((aController isKindOf: OPBormCommunicationController) and: [ aController source model owner ~= self model owner ])
]

{ #category : 'accessing' }
OPBormActivityController >> dependentElements [
	^ super dependentElements , model communications
]

{ #category : 'construction' }
OPBormActivityController >> diagramElementClass [

	^ BormActivityShape
]

{ #category : 'accessing' }
OPBormActivityController >> modelClass [
	^ BormActivity
]
