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

{ #category : 'accessing' }
OPBormRelationshipControllerTest >> diagramControllerClass [

	^ OPBormDiagramController
]

{ #category : 'accessing' }
OPBormRelationshipControllerTest >> diagramModelClass [
	^ BormORModel
]

{ #category : 'running' }
OPBormRelationshipControllerTest >> setUpSourceModel [

	| participant |
	participant := BormParticipant new.
	diagramController model add: participant.

	^ sourceModel := creationTargetController createModelIn: participant
]

{ #category : 'running' }
OPBormRelationshipControllerTest >> setUpTargetModel [

	| participant |
	participant := BormParticipant new.
	diagramController model add: participant.

	targetModel := targetController createModelIn: participant
]
