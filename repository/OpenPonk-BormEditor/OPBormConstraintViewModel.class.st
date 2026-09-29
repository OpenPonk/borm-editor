"
I am the ViewModel for BORM Constraints, linking the constraint model to its visual UI components and removal actions.
"
Class {
	#name : 'OPBormConstraintViewModel',
	#superclass : 'OPModelObjectViewModel',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPBormConstraintViewModel class >> modelClass [ ^ BormConstraint
]

{ #category : 'private' }
OPBormConstraintViewModel >> basicRemoveModel [

	self assert: self model owner constraint = self model.
	self model owner removeConstraint
]

{ #category : 'accessing' }
OPBormConstraintViewModel >> icon [ ^ OPBormEditorIcons constraint16Icon
]

{ #category : 'construction' }
OPBormConstraintViewModel >> registerModelIn: aParentModel [

	aParentModel constraint: self model
]
