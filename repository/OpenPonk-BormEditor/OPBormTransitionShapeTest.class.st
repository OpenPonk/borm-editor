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
