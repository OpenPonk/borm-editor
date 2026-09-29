"
I am the controller for BORM Constraints. I manage diagram interactions for constraint adornments attached to transitions or communications.
"
Class {
	#name : 'OPBormConstraintController',
	#superclass : 'OPBormAssociationEnhancementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPBormConstraintController class >> diagramElementClass [

	^ BormConstraintShape
]

{ #category : 'accessing' }
OPBormConstraintController class >> viewModelClass [
	^ OPBormConstraintViewModel
]

{ #category : 'visiting' }
OPBormConstraintController >> canVisitTarget: aController [
	^ aController canBeTargetForConstraint: self
]
