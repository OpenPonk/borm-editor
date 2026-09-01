"
I am the ViewModel for BORM States. I map state properties, such as initial and final markers, to Magritte UI forms.
"
Class {
	#name : 'OPBormStateViewModel',
	#superclass : 'OPBormProcessNodeViewModel',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPBormStateViewModel class >> modelClass [ ^ BormState
]

{ #category : 'forms' }
OPBormStateViewModel >> buildEditorForm: aForm [

	super buildEditorForm: aForm.
	(aForm addCheckbox: 'Initial')
		state: self model isInitial;
		whenChangedDo: [ :newValue |
			self model isInitial: newValue.
			self modelChanged ].
	(aForm addCheckbox: 'Final')
		state: self model isFinal;
		whenChangedDo: [ :newValue |
			self model isFinal: newValue.
			self modelChanged ]
]

{ #category : 'accessing' }
OPBormStateViewModel >> icon [ ^ OPBormEditorIcons state16Icon
]
