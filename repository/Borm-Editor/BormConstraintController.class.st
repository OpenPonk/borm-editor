Class {
	#name : #BormConstraintController,
	#superclass : #BormElementController,
	#category : 'Borm-Editor-Controllers'
}

{ #category : #'as yet unclassified' }
BormConstraintController >> constraintOnEdge: anElement [
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

{ #category : #hooks }
BormConstraintController >> createFigure [
	| element |
	element := RTLabel new
		color: Color black;
		elementOn: 'empty constraint'.
	element @ RTDraggable.
	self constraintOnEdge: element.
	^ element
]

{ #category : #hooks }
BormConstraintController >> createModel [
	^ self model
		ifNil: [ 
			self modelClass new
				name: 'constraint';
				yourself ]
]

{ #category : #accessing }
BormConstraintController >> modelClass [
	^ BormConstraint
]

{ #category : #hooks }
BormConstraintController >> refreshFigure [
	self figure trachelShape text: self model name.
	self diagramController view signalUpdate
]
