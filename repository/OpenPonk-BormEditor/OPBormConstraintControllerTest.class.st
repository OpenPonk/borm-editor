"
A BormConstraintControllerTest is a test class for testing the behavior of BormConstraintController
"
Class {
	#name : 'OPBormConstraintControllerTest',
	#superclass : 'OPBormAssociationEnhancementControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPBormConstraintControllerTest >> controllerClass [
	^ OPBormConstraintController
]

{ #category : 'accessing' }
OPBormConstraintControllerTest >> creationTargetControllerClass [
	^ OPBormTransitionController
]

{ #category : 'accessing' }
OPBormConstraintControllerTest >> creationTargetModelClass [
	^ BormTransition
]

{ #category : 'accessing' }
OPBormConstraintControllerTest >> diagramElementClass [

	^ BormConstraintShape
]

{ #category : 'accessing' }
OPBormConstraintControllerTest >> modelClass [
	^ BormConstraint
]

{ #category : 'running' }
OPBormConstraintControllerTest >> targetsSourceControllerClass [

	^ OPBormStateController
]
