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

{ #category : 'accessing' }
OPBormRelationshipController >> elementsToShowInside [

	^ self model constraints
]

{ #category : 'initialization' }
OPBormRelationshipController >> initialize [

	super initialize
]

{ #category : 'construction' }
OPBormRelationshipController >> registerModelInContainer: aParentModel [

	"do nothing"
]
