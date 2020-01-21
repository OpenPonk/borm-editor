Class {
	#name : #BormStateController,
	#superclass : #BormProcessNodeController,
	#category : 'Borm-Editor-Controllers'
}

{ #category : #hooks }
BormStateController >> buildEditorForm: aForm [
	super buildEditorForm: aForm.

	(aForm addCheckbox: 'Initial')
		state: self model isInitial;
		whenChangedDo: [ :newValue | self model isInitial: newValue ].

	(aForm addCheckbox: 'Final')
		state: self model isFinal;
		whenChangedDo: [ :newValue | self model isFinal: newValue ]
]

{ #category : #testing }
BormStateController >> canBeSourceFor: aController [
	^ aController isKindOf: BormTransitionController
]

{ #category : #testing }
BormStateController >> canBeTargetFor: aController [
	^ (aController isKindOf: BormTransitionController) and: [ aController source isKindOf: BormActivityController ]
]

{ #category : #accessing }
BormStateController >> modelClass [
	^ BormState
]

{ #category : #hooks }
BormStateController >> renderFigureIn: aView [
	figure := BormStateFigure on: self model.
	figure renderIn: aView.
	figure plusIcon
		when: TRMouseLeftClick
		do: [ self diagramController editor workbench
				openEditorOn: self model submodel ].
	self diagramController figureAdded: figure.
	^ figure
]
