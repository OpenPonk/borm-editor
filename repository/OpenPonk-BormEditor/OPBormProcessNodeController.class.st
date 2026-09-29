"
I am the abstract base controller for BORM process nodes (States and Activities). I manage diagram interactions, canvas targeting logic, and connectivity validation for internal participant flows.
"
Class {
	#name : 'OPBormProcessNodeController',
	#superclass : 'OPBormElementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'deprecation' }
OPBormProcessNodeController >> bormModels [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver bormModels' -> '`@receiver viewModel bormModels'.
	^ self viewModel bormModels
]

{ #category : 'connecting' }
OPBormProcessNodeController >> canBeSourceFor: aController [
	^ self subclassResponsibility
]

{ #category : 'connecting' }
OPBormProcessNodeController >> canBeTargetFor: aController [
	^ self subclassResponsibility
]

{ #category : 'construction' }
OPBormProcessNodeController >> hookDiagramElement [

	super hookDiagramElement.
	
	self diagramElement plusIconAction: [ 
		self diagramController editor workbench openEditorOn:
			self model submodel ]
]

{ #category : 'diagram elements' }
OPBormProcessNodeController >> intendedModelOfOwningDiagramElement [

	^ self model owner
]

{ #category : 'diagram elements' }
OPBormProcessNodeController >> unhookDiagramElement [

	super unhookDiagramElement.

	(self diagramElement ifNotExists: [ ^ self ]) plusIconAction: [  ]
]
