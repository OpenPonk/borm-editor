Class {
	#name : #OPBormAssociationEnhancementController,
	#superclass : #OPBormElementController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #construction }
OPBormAssociationEnhancementController >> constraintOnEdge: anElement [

	| edge const |
	edge := (self diagramController showWithoutDependentInDiagramModel:
		         model owner) figure.
	anElement withViewDo: [ :view | 
		const := OPRTRailConstraint new.
		const
			initialPosition: 0.5;
			distance: 10.
		const element: anElement connection: edge ]
]

{ #category : #'as yet unclassified' }
OPBormAssociationEnhancementController >> diagramElementOwner [

	^ (self diagramController showWithoutDependentInDiagramModel:
		   model owner) diagramElement
]
