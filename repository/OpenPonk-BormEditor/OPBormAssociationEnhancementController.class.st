Class {
	#name : #OPBormAssociationEnhancementController,
	#superclass : #OPBormElementController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #'as yet unclassified' }
OPBormAssociationEnhancementController >> diagramElementOwner [

	^ (self diagramController controllerForModel: model owner)
		  diagramElement
]
