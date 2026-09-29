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
	aForm bindCheckbox: 'Initial' property: #isInitial.
	aForm bindCheckbox: 'Final' property: #isFinal
]

{ #category : 'accessing' }
OPBormStateViewModel >> icon [ ^ OPBormEditorIcons state16Icon
]
