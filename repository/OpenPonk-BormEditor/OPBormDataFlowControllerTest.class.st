"
I am a unit test class verifying the behavior of OPBormDataFlowController, checking its capability to visually represent and attach to communication edges.
"
Class {
	#name : 'OPBormDataFlowControllerTest',
	#superclass : 'OPBormAssociationEnhancementControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'constants' }
OPBormDataFlowControllerTest class >> diagramElementClass [

	^ BormDataFlowShape
]

{ #category : 'constants' }
OPBormDataFlowControllerTest >> controllerClass [
	^ OPBormDataFlowController
]

{ #category : 'constants' }
OPBormDataFlowControllerTest >> modelClass [
	^ BormDataFlow
]
