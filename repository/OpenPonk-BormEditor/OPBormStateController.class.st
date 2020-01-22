Class {
	#name : #OPBormStateController,
	#superclass : #OPBormProcessNodeController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #hooks }
OPBormStateController >> buildEditorForm: aForm [
	super buildEditorForm: aForm.

	(aForm addCheckbox: 'Initial')
		state: self model isInitial;
		whenChangedDo: [ :newValue | self model isInitial: newValue ].

	(aForm addCheckbox: 'Final')
		state: self model isFinal;
		whenChangedDo: [ :newValue | self model isFinal: newValue ]
]

{ #category : #testing }
OPBormStateController >> canBeSourceFor: aController [
	^ aController isKindOf: OPBormTransitionController
]

{ #category : #testing }
OPBormStateController >> canBeTargetFor: aController [
	^ (aController isKindOf: OPBormTransitionController) and: [ aController source isKindOf: OPBormActivityController ]
]

{ #category : #accessing }
OPBormStateController >> modelClass [
	^ BormState
]

{ #category : #hooks }
OPBormStateController >> renderFigureIn: aView [
	figure := BormStateFigure on: self model.
	figure renderIn: aView.
	figure plusIcon
		when: TRMouseLeftClick
		do: [ self diagramController editor workbench
				openEditorOn: self model submodel ].
	self diagramController figureAdded: figure.
	^ figure
]
