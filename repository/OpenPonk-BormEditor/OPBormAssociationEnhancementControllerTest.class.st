Class {
	#name : 'OPBormAssociationEnhancementControllerTest',
	#superclass : 'OPBormElementControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'testing' }
OPBormAssociationEnhancementControllerTest class >> isAbstract [

	^ self = OPBormAssociationEnhancementControllerTest
]

{ #category : 'accessing' }
OPBormAssociationEnhancementControllerTest >> creationTargetControllerClass [

	^ OPBormCommunicationController
]

{ #category : 'accessing' }
OPBormAssociationEnhancementControllerTest >> creationTargetModelClass [

	^ BormCommunication
]

{ #category : 'accessing' }
OPBormAssociationEnhancementControllerTest >> setUpCreationTargetModel [

	| sourceParticipant targetParticipant sourceActivity targetActivity creationTargetModel |
	sourceParticipant := BormParticipant new.
	diagramController model add: sourceParticipant.
	targetParticipant := BormParticipant new.
	diagramController model add: targetParticipant.

	sourceActivity := BormActivity new.
	sourceParticipant add: sourceActivity.

	targetActivity := BormActivity new.
	targetParticipant add: targetActivity.

	creationTargetModel := self creationTargetModelClass new.
	creationTargetController model: creationTargetModel.
	creationTargetController
		modelSource: sourceActivity
		in: targetActivity.
	creationTargetController
		modelTarget: targetActivity
		in: targetActivity.
	^ creationTargetModel
]
