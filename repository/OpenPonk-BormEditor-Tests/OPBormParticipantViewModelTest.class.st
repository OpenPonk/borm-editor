"
Verifies ViewModel contracts for BORM participant elements.
"
Class {
	#name : 'OPBormParticipantViewModelTest',
	#superclass : 'OPAbstractViewModelTest',
	#category : 'OpenPonk-BormEditor-Tests-ViewModels',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'constants' }
OPBormParticipantViewModelTest >> modelClass [

	^ BormParticipant
]

{ #category : 'initialization' }
OPBormParticipantViewModelTest >> newRootModel [

	^ BormORModel named: 'TestORModel'
]

{ #category : 'constants' }
OPBormParticipantViewModelTest >> viewModelClass [

	^ OPBormParticipantViewModel
]
