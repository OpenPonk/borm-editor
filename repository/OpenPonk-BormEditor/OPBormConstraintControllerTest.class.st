"
A BormConstraintControllerTest is a test class for testing the behavior of BormConstraintController
"
Class {
	#name : #OPBormConstraintControllerTest,
	#superclass : #OPBormControllerTest,
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #accessing }
OPBormConstraintControllerTest >> controllerClass [
	^ OPBormConstraintController
]

{ #category : #accessing }
OPBormConstraintControllerTest >> figureClass [
	^ RTElement
]

{ #category : #accessing }
OPBormConstraintControllerTest >> modelClass [
	^ BormConstraint
]
