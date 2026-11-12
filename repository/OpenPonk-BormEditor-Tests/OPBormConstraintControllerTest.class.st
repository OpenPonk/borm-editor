"
I am a unit test class verifying the behavior of OPBormConstraintController, checking its ability to attach to and adorn transitions and communications.
"
Class {
	#name : 'OPBormConstraintControllerTest',
	#superclass : 'OPBormAssociationEnhancementControllerTest',
	#category : 'OpenPonk-BormEditor-Tests-Controllers',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPBormConstraintControllerTest class >> diagramElementClass [

	^ BormConstraintShape
]

{ #category : 'constants' }
OPBormConstraintControllerTest >> controllerClass [
	^ OPBormConstraintController
]

{ #category : 'constants' }
OPBormConstraintControllerTest >> modelClass [
	^ BormConstraint
]
