"
A BormConstraintControllerTest is a test class for testing the behavior of BormConstraintController
"
Class {
	#name : #OPBormConstraintControllerTest,
	#superclass : #OPBormAssociationEnhancementControllerTest,
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #accessing }
OPBormConstraintControllerTest >> controllerClass [
	^ OPBormConstraintController
]

{ #category : #accessing }
OPBormConstraintControllerTest >> diagramElementClass [

	^ BormConstraintShape
]

{ #category : #accessing }
OPBormConstraintControllerTest >> modelClass [
	^ BormConstraint
]

{ #category : #accessing }
OPBormConstraintControllerTest >> targetControllerClass [
	^ OPBormTransitionController
]

{ #category : #accessing }
OPBormConstraintControllerTest >> targetModelClass [
	^ BormTransition
]

{ #category : #running }
OPBormConstraintControllerTest >> targetsSourceControllerClass [

	^ OPBormStateController
]
