Class {
	#name : #OPBormFigureTest,
	#superclass : #TestCase,
	#instVars : [
		'canvas',
		'figure'
	],
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #accessing }
OPBormFigureTest >> figureClass [
	^ self subclassResponsibility
]

{ #category : #running }
OPBormFigureTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	figure := self diagramElementClass new
]
