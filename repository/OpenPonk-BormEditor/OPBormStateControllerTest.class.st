"
A BormStateControllerTest is a test class for testing the behavior of BormStateController
"
Class {
	#name : #OPBormStateControllerTest,
	#superclass : #OPBormControllerTest,
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #accessing }
OPBormStateControllerTest >> controllerClass [
	^ OPBormStateController
]

{ #category : #accessing }
OPBormStateControllerTest >> figureClass [
	^ BormStateFigure
]

{ #category : #accessing }
OPBormStateControllerTest >> modelClass [
	^ BormState
]
