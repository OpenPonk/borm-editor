Class {
	#name : #BormFigure,
	#superclass : #RTAbstractMultiElement,
	#instVars : [
		'figuresFactory'
	],
	#category : 'Borm-Editor-Visuals'
}

{ #category : #accessing }
BormFigure >> figuresFactory [
	^ figuresFactory ifNil: [ figuresFactory := BormFiguresFactory new ]
]
