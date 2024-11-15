Class {
	#name : 'OPBormConstraintController',
	#superclass : 'OPBormAssociationEnhancementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'visiting' }
OPBormConstraintController >> canVisitTarget: aController [
	^ aController canBeTargetForConstraint: self
]

{ #category : 'construction' }
OPBormConstraintController >> diagramElementClass [

	^ BormConstraintShape
]

{ #category : 'accessing' }
OPBormConstraintController >> modelClass [
	^ BormConstraint
]

{ #category : 'construction' }
OPBormConstraintController >> registerModelInContainer: aParentModel [

	aParentModel constraint: self model
]

{ #category : 'private' }
OPBormConstraintController >> removeModel [

	self assert: self model owner constraint = self model.
	self model owner removeConstraint
]
