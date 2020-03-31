Class {
	#name : #OPBormTransitionController,
	#superclass : #OPBormRelationshipController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #testing }
OPBormTransitionController >> canBeTargetForConstraint: aController [
	^ (super canBeTargetForConstraint: aController)
		and: [ self model source isKindOf: BormState ]
]

{ #category : #adding }
OPBormTransitionController >> canBeTargetForDataFlow: aDataFlow [
	^ false
]

{ #category : #hooks }
OPBormTransitionController >> connectionFeedback [
	^ OPInteractiveLine new
		lineBuilder: [ :fromFigure :toFigure | 
			OPRTStyledConnection new
				decorate: [ :deco | deco arrowHead ];
				withBorderAttachPoint;
				color: Color darkGray muchDarker;
				edgeFrom: fromFigure to: toFigure ];
		from: source figure
]

{ #category : #hooks }
OPBormTransitionController >> createEdgeFrom: fromElement to: toElement [
	| edge shape |
	shape := OPRTStyledConnection new
		withBorderAttachPoint;
		color: Color black;
		width: 2.
	(self model target isKindOf: BormState)
		ifTrue: [ shape decorations filledNarrowArrowHead ].
	edge := shape edgeFrom: fromElement to: toElement.
	^ edge
]

{ #category : #hooks }
OPBormTransitionController >> createModelIn: aParentModel [
	self model: self modelClass new.
	model source: self source model.
	model target: self target model.
	source model addTransition: model.
	target model addTransition: model.
	^ model
]

{ #category : #accessing }
OPBormTransitionController >> modelClass [
	^ BormTransition
]

{ #category : #destruction }
OPBormTransitionController >> removeModel [
	self model target removeTransition: self model.
	self model source removeTransition: self model
]

{ #category : #construction }
OPBormTransitionController >> renderFigureIn: aView [
	figure := super renderFigureIn: aView.
	(self diagramController showWithoutDependentInDiagramModel: self model source owner)
		figure trachelShape
		addCallback:
			(TRTranslationCallback
				block: [ :sh :step | figure shape translateBy: step for: figure ]).
	^ figure
]
