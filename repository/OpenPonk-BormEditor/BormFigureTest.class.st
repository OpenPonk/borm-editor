Class {
	#name : #BormFigureTest,
	#superclass : #TestCase,
	#instVars : [
		'view',
		'figure'
	],
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #accessing }
BormFigureTest >> figureClass [
	^ self subclassResponsibility
]

{ #category : #running }
BormFigureTest >> setUp [
	super setUp.
	view := RTView new.
	figure := self figureClass new
]
