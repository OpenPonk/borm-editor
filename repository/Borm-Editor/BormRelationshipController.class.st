Class {
	#name : #BormRelationshipController,
	#superclass : #OPDirectionalRelationshipController,
	#category : 'Borm-Editor-Controllers'
}

{ #category : #accessing }
BormRelationshipController >> allOwnedElementsInModel [
	model hasConstraint
		ifTrue: [ ^ {model constraint} ].
	^ {}
]

{ #category : #construction }
BormRelationshipController >> renderFigureIn: aView [
	figure := self
		createEdgeFrom: self source figure
		to: self target figure.
	figure @ OPRTConnectionHandles.
	figure renderIn: aView.
	figure trachelShape pushFront.
	self diagramController figureAdded: figure.
	^ figure
]

{ #category : #construction }
BormRelationshipController >> showInDiagram: aDiagramController [
	aDiagramController
		controllerForModel: model target
		ifNone: [ ^ aDiagramController
				controllerForModel: model source
				ifNone: [ self
						error:
							'Trying to create controller for relationship that depends on elements, but none of them is shown in diagram before' ] ].
	aDiagramController
		controllerForModel: model source
		ifNone: [ ^ self ].
	^ super showInDiagram: aDiagramController
]
