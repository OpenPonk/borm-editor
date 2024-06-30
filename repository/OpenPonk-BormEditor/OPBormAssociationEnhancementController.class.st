Class {
	#name : 'OPBormAssociationEnhancementController',
	#superclass : 'OPBormElementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPBormAssociationEnhancementController >> dependingOnElements [

	^ super dependingOnElements , (Set with: self model owner)
]

{ #category : 'diagram elements' }
OPBormAssociationEnhancementController >> diagramElementOwner [

	^ (self diagramController controllerForModel: model owner)
		  diagramElement
]
