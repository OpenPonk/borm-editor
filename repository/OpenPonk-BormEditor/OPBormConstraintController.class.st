Class {
	#name : #OPBormConstraintController,
	#superclass : #OPBormAssociationEnhancementController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #visiting }
OPBormConstraintController >> canVisitTarget: aController [
	^ aController canBeTargetForConstraint: self
]

{ #category : #construction }
OPBormConstraintController >> createModelIn: aParentModel [

	self model: self modelClass new.
	aParentModel constraint: model.
	^ model
]

{ #category : #construction }
OPBormConstraintController >> diagramElementClass [

	^ BormConstraintShape
]

{ #category : #accessing }
OPBormConstraintController >> modelClass [
	^ BormConstraint
]

{ #category : #private }
OPBormConstraintController >> removeModel [

	self assert: self model owner constraint = self model.
	self model owner removeConstraint
]
