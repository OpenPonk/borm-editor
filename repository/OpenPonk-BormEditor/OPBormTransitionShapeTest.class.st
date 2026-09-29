"
I am a unit test class verifying the behavior, source and target attachment, and directional markers of BORM Transition shapes.
"
Class {
	#name : 'OPBormTransitionShapeTest',
	#superclass : 'OPAbstractEdgeTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'instance creation' }
OPBormTransitionShapeTest >> modelClass [

	^ BormTransition
]

{ #category : 'hooks' }
OPBormTransitionShapeTest >> shapeClass [

	^ BormTransitionShape
]
