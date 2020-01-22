Class {
	#name : #BormActivityController,
	#superclass : #BormProcessNodeController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #accessing }
BormActivityController >> allOwnedElementsInModel [
	^ super allOwnedElementsInModel , model communications
]

{ #category : #testing }
BormActivityController >> canBeSourceFor: aController [
	^ (aController isKindOf: BormTransitionController) | (aController isKindOf: BormCommunicationController)
]

{ #category : #testing }
BormActivityController >> canBeTargetFor: aController [
	^ ((aController isKindOf: BormTransitionController) and: [ aController source isKindOf: BormStateController ])
		| ((aController isKindOf: BormCommunicationController) and: [ aController source model owner ~= self model owner ])
]

{ #category : #accessing }
BormActivityController >> modelClass [
	^ BormActivity
]

{ #category : #hooks }
BormActivityController >> renderFigureIn: aView [
	figure := BormActivityFigure on: self model.
	figure renderIn: aView.
	figure plusIcon
		when: TRMouseLeftClick
		do: [ self diagramController editor workbench
				openEditorOn: self model submodel ].
	self diagramController figureAdded: figure.
	^ figure
]
