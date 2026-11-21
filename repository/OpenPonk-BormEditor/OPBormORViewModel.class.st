"
View model for the root BORM Object Relation model, mapping top-level participants and metadata to workbench views and diagram controllers.
"
Class {
	#name : 'OPBormORViewModel',
	#superclass : 'OPModelObjectViewModel',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPBormORViewModel class >> commonModelClassPrefix [

	^ 'Borm'
]

{ #category : 'accessing' }
OPBormORViewModel class >> modelClass [ ^ BormORModel
]

{ #category : 'accessing' }
OPBormORViewModel >> childrenModels [

	^ self model participants
]

{ #category : 'accessing' }
OPBormORViewModel >> icon [ ^ OPBormEditorIcons oRModel16Icon
]

{ #category : 'accessing' }
OPBormORViewModel >> modelRootViewModel [

	^ self
]
