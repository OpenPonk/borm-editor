Class {
	#name : #OPBormTransitionController,
	#superclass : #OPBormRelationshipController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #testing }
OPBormTransitionController >> canBeTargetForConstraint: aController [
	^ (super canBeTargetForConstraint: aController)
		and: [ self model source isKindOf: BormState ]
]

{ #category : #adding }
OPBormTransitionController >> canBeTargetForDataFlow: aDataFlow [
	^ false
]

{ #category : #hooks }
OPBormTransitionController >> createModelIn: aParentModel [
	self model: self modelClass new.
	model source: self source model.
	model target: self target model.
	source model addTransition: model.
	target model addTransition: model.
	^ model
]

{ #category : #construction }
OPBormTransitionController >> diagramElementClass [

	^ BormTransitionShape
]

{ #category : #accessing }
OPBormTransitionController >> modelClass [
	^ BormTransition
]

{ #category : #destruction }
OPBormTransitionController >> removeModel [
	self model target removeTransition: self model.
	self model source removeTransition: self model
]
