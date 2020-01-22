Class {
	#name : #OPBormActivityController,
	#superclass : #OPBormProcessNodeController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #accessing }
OPBormActivityController >> allOwnedElementsInModel [
	^ super allOwnedElementsInModel , model communications
]

{ #category : #testing }
OPBormActivityController >> canBeSourceFor: aController [
	^ (aController isKindOf: OPBormTransitionController) | (aController isKindOf: OPBormCommunicationController)
]

{ #category : #testing }
OPBormActivityController >> canBeTargetFor: aController [
	^ ((aController isKindOf: OPBormTransitionController) and: [ aController source isKindOf: OPBormStateController ])
		| ((aController isKindOf: OPBormCommunicationController) and: [ aController source model owner ~= self model owner ])
]

{ #category : #accessing }
OPBormActivityController >> modelClass [
	^ BormActivity
]

{ #category : #hooks }
OPBormActivityController >> renderFigureIn: aView [
	figure := BormActivityFigure on: self model.
	figure renderIn: aView.
	figure plusIcon
		when: TRMouseLeftClick
		do: [ self diagramController editor workbench
				openEditorOn: self model submodel ].
	self diagramController figureAdded: figure.
	^ figure
]
