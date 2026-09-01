"
I am the ViewModel for BORM Activities. I connect the semantic activity model to its corresponding visual shape and UI property forms.
"
Class {
	#name : 'OPBormActivityViewModel',
	#superclass : 'OPBormProcessNodeViewModel',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPBormActivityViewModel class >> modelClass [ ^ BormActivity
]

{ #category : 'accessing' }
OPBormActivityViewModel >> childrenModels [

	^ super childrenModels , self model communications asArray
]

{ #category : 'accessing' }
OPBormActivityViewModel >> icon [ ^ OPBormEditorIcons activity16Icon
]
