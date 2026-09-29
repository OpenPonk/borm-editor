"
I am the ViewModel for a BORM Participant. I bridge the semantic participant model to its visual shape and manage Magritte forms for properties like role and type.
"
Class {
	#name : 'OPBormParticipantViewModel',
	#superclass : 'OPModelObjectViewModel',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPBormParticipantViewModel class >> modelClass [ ^ BormParticipant
]

{ #category : 'forms' }
OPBormParticipantViewModel >> buildEditorForm: aForm [
	| droplist |
	super buildEditorForm: aForm.
	droplist := aForm
		bindDroplist: 'Type'
		property: #type
		items: #( #Person #System #Organization ).
	droplist displayIcon: [ :itemType | BormParticipantShape typeIconFor: itemType ].
	droplist display: [ :itemType | itemType asString ]
]

{ #category : 'accessing' }
OPBormParticipantViewModel >> childrenModels [

	^ self model nodes
]

{ #category : 'accessing' }
OPBormParticipantViewModel >> essentialChildrenModels [

	| nodes |
	nodes := self model nodes.
	^ nodes asArray , nodes flatCollectAsSet: [ :each | each transitions ]
]

{ #category : 'accessing' }
OPBormParticipantViewModel >> icon [ ^ BormParticipantShape typeIconFor: self model type
]
