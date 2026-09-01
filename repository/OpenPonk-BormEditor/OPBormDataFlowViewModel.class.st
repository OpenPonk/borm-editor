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

	super buildEditorForm: aForm.
	(aForm addDroplist: 'Type')
		items: #( #input #output );
		display: [ :type | type asString ];
		selectItem: self model type;
		whenSelectedItemChangedDo: [ :newValue |
			self model type: newValue.
			self modelChanged ]
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
