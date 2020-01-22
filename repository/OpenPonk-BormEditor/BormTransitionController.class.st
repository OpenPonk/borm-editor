Class {
	#name : #BormTransitionController,
	#superclass : #BormRelationshipController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #adding }
BormTransitionController >> addAsTargetFor: aConstraintController [
	self addAsTargetForConstraint: aConstraintController
]

{ #category : #adding }
BormTransitionController >> addAsTargetForConstraint: aConstraintController [
	self assert: (self canBeTargetFor: aConstraintController).
	self model constraint: aConstraintController loadModel.
	aConstraintController attachTo: self diagramController
]

{ #category : #testing }
BormTransitionController >> canBeTargetFor: aController [
	^ self canBeTargetForConstraint: aController
]

{ #category : #testing }
BormTransitionController >> canBeTargetForConstraint: aController [
	^ self model hasConstraint not
		and: [ (aController isKindOf: BormConstraintController) and: [ self model source isKindOf: BormState ] ]
]

{ #category : #hooks }
BormTransitionController >> connectionFeedback [
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
BormTransitionController >> createEdgeFrom: fromElement to: toElement [
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
BormTransitionController >> createModel [
	| transition |
	self model ifNotNil: [ ^ self model ].
	transition := super createModel.
	source model addTransition: transition.
	target model addTransition: transition.
	^ transition
]

{ #category : #accessing }
BormTransitionController >> modelClass [
	^ BormTransition
]

{ #category : #destruction }
BormTransitionController >> removeModel [
	self model target removeTransition: self model.
	self model source removeTransition: self model
]

{ #category : #construction }
BormTransitionController >> renderFigureIn: aView [
	figure := super renderFigureIn: aView.
	(self diagramController controllerForModel: self model source owner)
		figure trachelShape
		addCallback:
			(TRTranslationCallback
				block: [ :sh :step | figure shape translateBy: step for: figure ]).
	^ figure
]
