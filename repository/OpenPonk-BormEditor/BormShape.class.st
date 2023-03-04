Class {
	#name : #BormShape,
	#superclass : #OPShape,
	#instVars : [
		'shapesFactory'
	],
	#category : #'OpenPonk-BormEditor-Visuals'
}

{ #category : #accessing }
BormShape >> shapesFactory [
	^ shapesFactory ifNil: [ shapesFactory := BormShapesFactory new ]
]
