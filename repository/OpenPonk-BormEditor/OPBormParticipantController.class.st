Class {
	#name : 'OPBormParticipantController',
	#superclass : 'OPBormElementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'forms' }
OPBormParticipantController >> buildEditorForm: aForm [

	super buildEditorForm: aForm.
	(aForm addDroplist: 'Type')
		items: #( #Person #System #Organization );
		displayIcon: [ :type | BormParticipantShape typeIconFor: type ];
		display: [ :type | type asString ];
		selectItem: self model type;
		whenSelectedItemChangedDo: [ :newValue |
			self model type: newValue.
			self diagramElement modelChanged ]
]

{ #category : 'testing' }
OPBormParticipantController >> canBeTargetFor: aController [
	^ aController isKindOf: OPBormProcessNodeController
]

{ #category : 'construction' }
OPBormParticipantController >> diagramElementClass [

	^ BormParticipantShape
]

{ #category : 'accessing' }
OPBormParticipantController >> elementsToShowInside [

	^ model nodes , (model nodes flatCollect: [ :each | each outgoing ])
]

{ #category : 'construction' }
OPBormParticipantController >> hookDiagramElement [

	super hookDiagramElement.

	diagramElement innerRoassalShapesBlock: [ self nodeRoassalShapes ]
]

{ #category : 'accessing' }
OPBormParticipantController >> modelClass [
	^ BormParticipant
]

{ #category : 'as yet unclassified' }
OPBormParticipantController >> nodeRoassalShapes [

	^ self model nodes
		  collect: [ :eachModel | 
			  self diagramController
				  controllerForModel: eachModel
				  ifFound: #roassalShape ]
		  thenSelect: #isNotNil
]

{ #category : 'destruction' }
OPBormParticipantController >> removeModel [

	self model owner remove: self model.
	super removeModel
]

{ #category : 'diagram elements' }
OPBormParticipantController >> unhookDiagramElement [

	super unhookDiagramElement.
	(self diagramElement ifNotExists: [ ^ self ])
		innerRoassalShapesBlock: [  ]
]
