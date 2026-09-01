"
I am the controller for BORM Participants. I manage canvas interactions, connection targeting rules, and handle the rendering hooks for the participant's nested process nodes.
"
Class {
	#name : 'OPBormParticipantController',
	#superclass : 'OPBormElementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPBormParticipantController class >> diagramElementClass [

	^ BormParticipantShape
]

{ #category : 'accessing' }
OPBormParticipantController class >> viewModelClass [
	^ OPBormParticipantViewModel
]

{ #category : 'connecting' }
OPBormParticipantController >> canBeTargetFor: aController [
	^ aController isKindOf: OPBormProcessNodeController
]

{ #category : 'construction' }
OPBormParticipantController >> hookDiagramElement [

	super hookDiagramElement.

	self diagramElement innerRoassalShapesBlock: [
		self nodeRoassalShapes ]
]

{ #category : 'accessing' }
OPBormParticipantController >> nodeRoassalShapes [

	^ self model nodes
		  collect: [ :eachModel | 
			  self diagramController
				  controllerForModel: eachModel
				  ifFound: #roassalShape ]
		  thenSelect: #isNotNil
]

{ #category : 'diagram elements' }
OPBormParticipantController >> unhookDiagramElement [

	super unhookDiagramElement.
	(self diagramElement ifNotExists: [ ^ self ])
		innerRoassalShapesBlock: [  ]
]
