Class {
	#name : 'OPBormAssociationEnhancementController',
	#superclass : 'OPBormElementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPBormAssociationEnhancementController >> dependingOnElements [

	^ super dependingOnElements , (Set with:
		   (self model owner ifNil: [
			    self error: 'There is no owner of ' , self model asString ]))
]

{ #category : 'diagram elements' }
OPBormAssociationEnhancementController >> owner [

	^ self diagramController controllerForModel: self model owner
]
