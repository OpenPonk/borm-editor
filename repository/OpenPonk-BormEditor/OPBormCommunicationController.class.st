"
I am the controller for BORM Communications. I manage diagram interactions and connection rules for inter-participant communication edges, including data flow attachments.
"
Class {
	#name : 'OPBormCommunicationController',
	#superclass : 'OPBormRelationshipController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPBormCommunicationController class >> diagramElementClass [

	^ BormCommunicationShape
]

{ #category : 'accessing' }
OPBormCommunicationController class >> viewModelClass [
	^ OPBormCommunicationViewModel
]

{ #category : 'testing' }
OPBormCommunicationController >> canBeTargetForDataFlow: aController [
	^ true
]

{ #category : 'diagram elements' }
OPBormCommunicationController >> intendedModelOfOwningDiagramElement [

	^ self diagramController model
]
