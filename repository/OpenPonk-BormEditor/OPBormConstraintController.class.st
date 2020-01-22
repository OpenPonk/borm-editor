Class {
	#name : #OPBormConstraintController,
	#superclass : #OPBormElementController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #visiting }
OPBormConstraintController >> canVisitTarget: aController [
	^ aController canBeTargetForConstraint: self
]

{ #category : #'as yet unclassified' }
OPBormConstraintController >> constraintOnEdge: anElement [
	| edge const |
	edge := (self diagramController controllerForModel: model owner) figure.
	anElement
		withViewDo:
			[ :view | 
			const := OPRTRailConstraint new.
			const
				initialPosition: 0.5;
				distance: 10.
			const element: anElement connection: edge ]
]

{ #category : #accessing }
OPBormConstraintController >> modelClass [
	^ BormConstraint
]

{ #category : #hooks }
OPBormConstraintController >> refreshFigure [
	self figure trachelShape text: self model name.
	super refreshFigure
]

{ #category : #hooks }
OPBormConstraintController >> renderFigureIn: aView [
	figure := RTLabel new
		color: Color black;
		elementOn: 'empty constraint'.
	figure @ RTDraggable.
	figure renderIn: aView.
	figure trachelShape pushFront.
	self constraintOnEdge: figure.
	^ figure
]

{ #category : #visiting }
OPBormConstraintController >> visitTarget: aController [
	^ aController addAsTargetForConstraint: self
]
