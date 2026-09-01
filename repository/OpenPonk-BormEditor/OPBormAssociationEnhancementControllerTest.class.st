"
I am an abstract base test class verifying the behavior of controllers that manage association adornments (enhancements) like constraints and data flows.
"
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

{ #category : 'constants' }
OPBormAssociationEnhancementControllerTest >> creationTargetControllerClass [

	^ OPBormCommunicationController
]

{ #category : 'constants' }
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
    creationTargetModel source: sourceActivity.
    creationTargetModel target: targetActivity.

    diagramController model add: creationTargetModel.

    creationTargetController viewModelRegistry: diagramController viewModelRegistry.
    creationTargetController model: creationTargetModel.

    ^ creationTargetModel
]
