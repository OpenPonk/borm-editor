Class {
	#name : #OPBormRelationshipController,
	#superclass : #OPDirectionalRelationshipController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #accessing }
OPBormRelationshipController >> allOwnedElementsInModel [
	^ model constraints
]

{ #category : #testing }
OPBormRelationshipController >> isHideable [
	^ true
]

{ #category : #construction }
OPBormRelationshipController >> renderFigureIn: aView [
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
OPBormRelationshipController >> showInDiagram: aDiagramController [
	"protocol: #construction"

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
