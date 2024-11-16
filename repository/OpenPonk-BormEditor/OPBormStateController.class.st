Class {
	#name : 'OPBormStateController',
	#superclass : 'OPBormProcessNodeController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'forms' }
OPBormStateController >> buildEditorForm: aForm [

	super buildEditorForm: aForm.
	(aForm addCheckbox: 'Initial')
		state: self model isInitial;
		whenChangedDo: [ :newValue |
			self model isInitial: newValue.
			self modelChanged ].
	(aForm addCheckbox: 'Final')
		state: self model isFinal;
		whenChangedDo: [ :newValue |
			self model isFinal: newValue.
			self modelChanged ]
]

{ #category : 'testing' }
OPBormStateController >> canBeSourceFor: aController [
	^ aController isKindOf: OPBormTransitionController
]

{ #category : 'testing' }
OPBormStateController >> canBeTargetFor: aController [
	^ (aController isKindOf: OPBormTransitionController) and: [ aController source isKindOf: OPBormActivityController ]
]

{ #category : 'construction' }
OPBormStateController >> diagramElementClass [

	^ BormStateShape
]

{ #category : 'accessing' }
OPBormStateController >> modelClass [
	^ BormState
]
