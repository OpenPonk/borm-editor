Class {
	#name : #OPBormShapeTest,
	#superclass : #TestCase,
	#instVars : [
		'canvas',
		'diagramElement'
	],
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #accessing }
OPBormShapeTest >> diagramElementClass [
	^ self subclassResponsibility
]

{ #category : #running }
OPBormShapeTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	diagramElement := self diagramElementClass new
]
