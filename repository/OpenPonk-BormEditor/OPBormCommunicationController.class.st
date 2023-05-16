Class {
	#name : #OPBormCommunicationController,
	#superclass : #OPBormRelationshipController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #testing }
OPBormCommunicationController >> canBeTargetForDataFlow: aController [
	^ true
]

{ #category : #accessing }
OPBormCommunicationController >> createModelIn: aParentModel [
	self model: self modelClass new.
	model source: self source model.
	model target: self target model.
	source model send: model.
	target model receive: model.
	^ model
]

{ #category : #construction }
OPBormCommunicationController >> diagramElementClass [

	^ BormCommunicationShape
]

{ #category : #accessing }
OPBormCommunicationController >> elementsToShowInside [
	^ super elementsToShowInside , model dataFlows
]

{ #category : #accessing }
OPBormCommunicationController >> modelClass [
	^ BormCommunication
]

{ #category : #destruction }
OPBormCommunicationController >> removeModel [
	self model target removeCommunication: self model.
	self model source removeCommunication: self model
]
