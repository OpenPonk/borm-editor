"
I am the ViewModel for BORM Transitions. I bridge the semantic transition model with its visual edge shape and manage nested constraint children.
"
Class {
	#name : 'OPBormTransitionViewModel',
	#superclass : 'OPDirectedAssociationViewModel',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPBormTransitionViewModel class >> modelClass [ ^ BormTransition
]

{ #category : 'construction' }
OPBormTransitionViewModel >> attachModelFrom: sourceViewModel to: targetViewModel [

	self model source: sourceViewModel model.
	self model target: targetViewModel model.
	sourceViewModel model addTransition: self model.
	targetViewModel model addTransition: self model
]

{ #category : 'private' }
OPBormTransitionViewModel >> basicRemoveModel [

	self model target removeTransition: self model.
	self model source removeTransition: self model
]

{ #category : 'accessing' }
OPBormTransitionViewModel >> essentialChildrenModels [

	^ self model constraints asArray
]

{ #category : 'accessing' }
OPBormTransitionViewModel >> icon [ ^ OPBormEditorIcons transition16Icon
]

{ #category : 'construction' }
OPBormTransitionViewModel >> registerModelIn: aParentModel [
	"There is no owner except of source/target"

	
]
