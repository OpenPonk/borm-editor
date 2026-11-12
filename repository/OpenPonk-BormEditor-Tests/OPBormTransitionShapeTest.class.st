"
I am a unit test class verifying the behavior, source and target attachment, and directional markers of BORM Transition shapes.
"
Class {
	#name : 'OPBormTransitionShapeTest',
	#superclass : 'OPAbstractEdgeTest',
	#category : 'OpenPonk-BormEditor-Tests-DiagramElements',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'DiagramElements'
}

{ #category : 'instance creation' }
OPBormTransitionShapeTest >> modelClass [

	^ BormTransition
]

{ #category : 'hooks' }
OPBormTransitionShapeTest >> shapeClass [

	^ BormTransitionShape
]
