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

	super buildEditorForm: aForm.
	(aForm addDroplist: 'Type')
		items: #( #Person #System #Organization );
		displayIcon: [ :type | BormParticipantShape typeIconFor: type ];
		display: [ :type | type asString ];
		selectItem: self model type;
		whenSelectedItemChangedDo: [ :newValue |
			self model type: newValue.
			self modelChanged ]
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
