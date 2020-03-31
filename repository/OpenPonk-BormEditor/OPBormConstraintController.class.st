Class {
	#name : #OPBormConstraintController,
	#superclass : #OPBormElementController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #visiting }
OPBormConstraintController >> canVisitTarget: aController [
	^ aController canBeTargetForConstraint: self
]

{ #category : #construction }
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

{ #category : #construction }
OPBormConstraintController >> createModelIn: aParentModel [
	self model: self modelClass new.
	aParentModel constraint: model.
	^ model
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

{ #category : #private }
OPBormConstraintController >> removeModel [
	self assert: self model owner constraint equals: self model.
	self model owner removeConstraint
]

{ #category : #hooks }
OPBormConstraintController >> renderFigureIn: aView [
	figure := RTLabel new
		color: Color black;
		height: 12;
		elementOn: 'empty constraint'.
	figure @ RTDraggable.
	figure renderIn: aView.
	figure trachelShape pushFront.
	self constraintOnEdge: figure.
	self diagramController figureAdded: figure.
	^ figure
]
