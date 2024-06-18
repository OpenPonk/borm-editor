Class {
	#name : 'OPBormAssociationEnhancementController',
	#superclass : 'OPBormElementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'diagram elements' }
OPBormAssociationEnhancementController >> diagramElementOwner [

	^ (self diagramController controllerForModel: model owner)
		  diagramElement
]
