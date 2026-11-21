"
Verifies directional relationship ViewModel contracts for BORM communication elements between participant activities.
"
Class {
	#name : 'OPBormCommunicationViewModelTest',
	#superclass : 'OPAbstractDirectionalRelationshipViewModelTest',
	#instVars : [
		'senderParticipant',
		'receiverParticipant'
	],
	#category : 'OpenPonk-BormEditor-Tests-ViewModels',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'constants' }
OPBormCommunicationViewModelTest >> modelClass [

	^ BormCommunication
]

{ #category : 'initialization' }
OPBormCommunicationViewModelTest >> newRootModel [

	^ BormORModel named: 'TestORModel'
]

{ #category : 'constants' }
OPBormCommunicationViewModelTest >> sourceModelClass [

	^ BormActivity
]

{ #category : 'initialization' }
OPBormCommunicationViewModelTest >> sourceParentModel [

	^ senderParticipant ifNil: [
			  senderParticipant := BormParticipant named: 'Sender'.
			  rootModel add: senderParticipant.
			  senderParticipant ]
]

{ #category : 'constants' }
OPBormCommunicationViewModelTest >> targetModelClass [

	^ BormActivity
]

{ #category : 'initialization' }
OPBormCommunicationViewModelTest >> targetParentModel [

	^ receiverParticipant ifNil: [
			  receiverParticipant := BormParticipant named: 'Receiver'.
			  rootModel add: receiverParticipant.
			  receiverParticipant ]
]

{ #category : 'running' }
OPBormCommunicationViewModelTest >> tearDown [

	receiverParticipant := nil.
	senderParticipant := nil.
	super tearDown
]

{ #category : 'constants' }
OPBormCommunicationViewModelTest >> viewModelClass [

	^ OPBormCommunicationViewModel
]
