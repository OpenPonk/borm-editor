Class {
	#name : 'OPBormTransitionController',
	#superclass : 'OPBormRelationshipController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'testing' }
OPBormTransitionController >> canBeTargetForConstraint: aController [
	^ (super canBeTargetForConstraint: aController)
		and: [ self model source isKindOf: BormState ]
]

{ #category : 'adding' }
OPBormTransitionController >> canBeTargetForDataFlow: aDataFlow [
	^ false
]

{ #category : 'construction' }
OPBormTransitionController >> diagramElementClass [

	^ BormTransitionShape
]

{ #category : 'accessing' }
OPBormTransitionController >> modelClass [
	^ BormTransition
]

{ #category : 'hooks' }
OPBormTransitionController >> modelSource: aModel in: aParentModel [

	(super modelSource: aModel in: aParentModel) ifFalse: [ ^ false ].
	self modelSource addTransition: model.
	^ true
]

{ #category : 'hooks' }
OPBormTransitionController >> modelTarget: aModel in: aParentModel [

	(super modelTarget: aModel in: aParentModel) ifFalse: [ ^ false ].
	self modelTarget addTransition: model.
	^ true
]

{ #category : 'destruction' }
OPBormTransitionController >> removeModel [

	self model target removeTransition: self model.
	self model source removeTransition: self model.
	super removeModel
]
