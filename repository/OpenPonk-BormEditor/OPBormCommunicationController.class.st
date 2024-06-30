Class {
	#name : 'OPBormCommunicationController',
	#superclass : 'OPBormRelationshipController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'testing' }
OPBormCommunicationController >> canBeTargetForDataFlow: aController [
	^ true
]

{ #category : 'construction' }
OPBormCommunicationController >> diagramElementClass [

	^ BormCommunicationShape
]

{ #category : 'accessing' }
OPBormCommunicationController >> elementsToShowInside [
	^ super elementsToShowInside , model dataFlows
]

{ #category : 'accessing' }
OPBormCommunicationController >> modelClass [
	^ BormCommunication
]

{ #category : 'accessing' }
OPBormCommunicationController >> modelSource: aModel in: aParentModel [

	(super modelSource: aModel in: aParentModel) ifFalse: [ ^ false ].
	self modelSource send: model.
	^ true
]

{ #category : 'accessing' }
OPBormCommunicationController >> modelTarget: aModel in: aParentModel [

	(super modelTarget: aModel in: aParentModel) ifFalse: [ ^ false ].
	self modelTarget receive: model.
	^ true
]

{ #category : 'destruction' }
OPBormCommunicationController >> removeModel [
	self model target removeCommunication: self model.
	self model source removeCommunication: self model
]
