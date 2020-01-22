Class {
	#name : #BormFigure,
	#superclass : #RTAbstractMultiElement,
	#instVars : [
		'figuresFactory'
	],
	#category : #'OpenPonk-BormEditor-Visuals'
}

{ #category : #accessing }
BormFigure >> figuresFactory [
	^ figuresFactory ifNil: [ figuresFactory := BormFiguresFactory new ]
]
