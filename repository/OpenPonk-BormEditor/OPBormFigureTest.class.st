Class {
	#name : #OPBormFigureTest,
	#superclass : #TestCase,
	#instVars : [
		'view',
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
	view := RTView new.
	figure := self figureClass new
]
