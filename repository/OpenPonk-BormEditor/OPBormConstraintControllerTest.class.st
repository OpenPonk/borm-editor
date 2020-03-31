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

{ #category : #running }
OPBormConstraintControllerTest >> setUpTarget [
	| targetsSourceController targetsTargetController |
	targetController := self targetControllerClass new.
	targetController diagramController: diagramController.
	targetsSourceController := OPBormStateController new.
	targetsSourceController diagramController: diagramController.
	targetsSourceController createModelIn: diagramController model.
	targetsTargetController := OPBormActivityController new.
	targetsTargetController diagramController: diagramController.
	targetsTargetController createModelIn: diagramController model.
	targetController
		source: targetsTargetController;
		target: targetsSourceController.
	targetController createModelIn: diagramController model
]

{ #category : #accessing }
OPBormConstraintControllerTest >> targetControllerClass [
	^ OPBormTransitionController
]

{ #category : #accessing }
OPBormConstraintControllerTest >> targetModelClass [
	^ BormTransition
]
