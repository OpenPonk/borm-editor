Class {
	#name : #OPBormConstraintController,
	#superclass : #OPBormAssociationEnhancementController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #visiting }
OPBormConstraintController >> canVisitTarget: aController [
	^ aController canBeTargetForConstraint: self
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

	self figure trachelShape text:
		(self model name ifEmpty: [ 'condition' ]).
	^ super refreshFigure
]

{ #category : #private }
OPBormConstraintController >> removeModel [

	self assert: self model owner constraint = self model.
	self model owner removeConstraint
]

{ #category : #hooks }
OPBormConstraintController >> renderFigureIn: aView [

	self diagramController addingFigureFor: self.
	figure := RTLabel new
		          color: Color black;
		          height: 12;
		          elementOn: self model.
	figure @ RTDraggable.
	figure renderIn: aView.
	figure trachelShape pushFront.
	self constraintOnEdge: figure.
	self refreshFigure.
	^ self diagramController addedFigureFor: self
]
