"
I am the controller for BORM Transitions. I manage the interactions and rendering of the directed edges defining the internal process flow of a participant.
"
Class {
	#name : 'OPBormTransitionController',
	#superclass : 'OPBormRelationshipController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPBormTransitionController class >> diagramElementClass [

	^ BormTransitionShape
]

{ #category : 'accessing' }
OPBormTransitionController class >> viewModelClass [
	^ OPBormTransitionViewModel
]

{ #category : 'testing' }
OPBormTransitionController >> canBeTargetForConstraint: aController [
	^ (super canBeTargetForConstraint: aController)
		and: [ self model source isKindOf: BormState ]
]

{ #category : 'testing' }
OPBormTransitionController >> canBeTargetForDataFlow: aDataFlow [
	^ false
]

{ #category : 'diagram elements' }
OPBormTransitionController >> intendedModelOfOwningDiagramElement [

	^ self viewModel modelSource owner
]
