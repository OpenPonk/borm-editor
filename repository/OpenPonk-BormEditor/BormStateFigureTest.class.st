Class {
	#name : #BormStateFigureTest,
	#superclass : #BormFigureTest,
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #accessing }
BormStateFigureTest >> figureClass [
	^ BormStateFigure
]

{ #category : #'as yet unclassified' }
BormStateFigureTest >> testAdd [
	figure model: BormState new.
	view add: figure.
	self assert: view elements asSet equals: {figure} asSet , figure ownedElements
]

{ #category : #'as yet unclassified' }
BormStateFigureTest >> testRemove [
	figure model: BormState new.
	view add: figure.
	figure remove.
	self assert: view elements asArray equals: #()
]

{ #category : #'as yet unclassified' }
BormStateFigureTest >> testRemove1 [
	figure
		model:
			(BormState new
				beInitial;
				beFinal).
	view add: figure.
	figure remove.
	self assert: view elements asArray equals: #()
]
