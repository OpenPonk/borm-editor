"
I am an abstract base test class verifying the source and target mapping logic for directional BORM relationship controllers (Transitions and Communications).
"
Class {
	#name : 'OPBormRelationshipControllerTest',
	#superclass : 'OPAbstractDirectionalRelationshipControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'testing' }
OPBormRelationshipControllerTest class >> isAbstract [
	^ self = OPBormRelationshipControllerTest
]

{ #category : 'constants' }
OPBormRelationshipControllerTest >> diagramControllerClass [

	^ OPBormDiagramController
]

{ #category : 'constants' }
OPBormRelationshipControllerTest >> diagramModelClass [
	^ BormORModel
]

{ #category : 'initialization' }
OPBormRelationshipControllerTest >> setUpSourceModel [

	| participant |
	participant := BormParticipant new.
	diagramController model add: participant.

	^ sourceModel := creationTargetController createModelIn: participant
]

{ #category : 'initialization' }
OPBormRelationshipControllerTest >> setUpTargetModel [

	| participant |
	participant := BormParticipant new.
	diagramController model add: participant.

	targetModel := targetController createModelIn: participant
]
