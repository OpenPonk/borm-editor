"
I am the controller for BORM Data Flows. I manage diagram interactions for data flow adornments attached to communication edges.
"
Class {
	#name : 'OPBormDataFlowController',
	#superclass : 'OPBormAssociationEnhancementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPBormDataFlowController class >> diagramElementClass [

	^ BormDataFlowShape
]

{ #category : 'accessing' }
OPBormDataFlowController class >> viewModelClass [
	^ OPBormDataFlowViewModel
]

{ #category : 'testing' }
OPBormDataFlowController >> canVisitTarget: aController [
	^ aController canBeTargetForDataFlow: self
]
