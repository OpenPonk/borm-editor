"
I am the ViewModel for the root BORM Object Relation Model. I manage the mapping between the top-level semantic model and its UI representation, identifying essential children like participants.
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
OPBormORViewModel >> essentialChildrenModels [

	| participants |
	participants := self model participants.
	^ participants asArray , (participants flatCollectAsSet: [ :each |
		   each nodes flatCollectAsSet: [ :eachNode |
			   eachNode communications ] ])
]

{ #category : 'accessing' }
OPBormORViewModel >> icon [ ^ OPBormEditorIcons oRModel16Icon
]

{ #category : 'accessing' }
OPBormORViewModel >> modelRootViewModel [

	^ self
]
