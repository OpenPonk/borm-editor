"
I am the abstract base controller for directional BORM relationships. I handle common connection targeting logic and manage attachments for constraints and data flows.
"
Class {
	#name : 'OPBormRelationshipController',
	#superclass : 'OPDirectionalRelationshipController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'connecting' }
OPBormRelationshipController >> canBeTargetFor: aController [

	^ (aController respondsTo: #canVisitTarget:) and: [
		  aController canVisitTarget: self ]
]

{ #category : 'testing' }
OPBormRelationshipController >> canBeTargetForConstraint: aController [
	^ self model hasConstraint not
]

{ #category : 'testing' }
OPBormRelationshipController >> canBeTargetForDataFlow: aDataFlow [
	^ self subclassResponsibility
]
