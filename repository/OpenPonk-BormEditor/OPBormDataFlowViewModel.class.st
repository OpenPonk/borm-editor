"
I am the ViewModel for BORM Data Flows, managing properties, creation priorities, and Magritte UI forms.
"
Class {
	#name : 'OPBormDataFlowViewModel',
	#superclass : 'OPModelObjectViewModel',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPBormDataFlowViewModel class >> modelClass [ ^ BormDataFlow
]

{ #category : 'forms' }
OPBormDataFlowViewModel >> buildEditorForm: aForm [
	| droplist |
	super buildEditorForm: aForm.
	droplist := aForm
		bindDroplist: 'Type'
		property: #type
		items: #( #input #output ).
	droplist display: [ :itemType | itemType asString ]
]

{ #category : 'accessing' }
OPBormDataFlowViewModel >> creationPriority [
	"Data Flows are visually placed on top of Communications. 
	 We must ensure that Communication (priority 100) is created earlier."
	^ 150
]

{ #category : 'accessing' }
OPBormDataFlowViewModel >> icon [ ^ OPBormEditorIcons dataFlow16Icon
]
