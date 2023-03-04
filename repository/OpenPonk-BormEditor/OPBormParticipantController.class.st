Class {
	#name : #OPBormParticipantController,
	#superclass : #OPBormElementController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #hooks }
OPBormParticipantController >> buildEditorForm: aForm [

	super buildEditorForm: aForm.
	(aForm addDroplist: 'Type')
		items: #( #Person #System #Organization );
		displayIcon: [ :type | self typeIconFor: type ];
		display: [ :type | type asString ];
		selectItem: self model type;
		whenSelectedItemChangedDo: [ :newValue | 
			self model type: newValue.
			self refreshFigure ]
]

{ #category : #testing }
OPBormParticipantController >> canBeTargetFor: aController [
	^ aController isKindOf: OPBormProcessNodeController
]

{ #category : #figures }
OPBormParticipantController >> createDiagramElement [

	super createDiagramElement.

	diagramElement
		innerRoassalShapesBlock: [ self nodeRoassalShapes ];
		typeIconProvider: self
]

{ #category : #construction }
OPBormParticipantController >> diagramElementClass [

	^ BormParticipantShape
]

{ #category : #accessing }
OPBormParticipantController >> elementsToShowInside [
	^ model nodes , (model nodes flatCollect: [ :each | each outgoing ])
]

{ #category : #accessing }
OPBormParticipantController >> modelClass [
	^ BormParticipant
]

{ #category : #'as yet unclassified' }
OPBormParticipantController >> nodeRoassalShapes [

	^ self model nodes
		  collect: [ :eachModel | 
			  self diagramController
				  controllerForModel: eachModel
				  ifFound: #roassalShape ]
		  thenSelect: #isNotNil
]

{ #category : #destruction }
OPBormParticipantController >> removeModel [
	self diagramController model remove: self model
]

{ #category : #hooks }
OPBormParticipantController >> typeIconFor: aType [

	aType = BormParticipantType Person ifTrue: [ 
		^ OPBormEditorIcons personIcon ].
	aType = BormParticipantType System ifTrue: [ 
		^ OPBormEditorIcons bormSystemIcon ].
	aType = BormParticipantType Organization ifTrue: [ 
		^ OPBormEditorIcons organizationIcon ]
]
