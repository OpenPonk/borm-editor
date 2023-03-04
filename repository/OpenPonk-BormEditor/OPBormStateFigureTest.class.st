Class {
	#name : #OPBormStateFigureTest,
	#superclass : #OPBormFigureTest,
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #accessing }
OPBormStateFigureTest >> figureClass [
	^ BormStateShape
]

{ #category : #'as yet unclassified' }
OPBormStateFigureTest >> testAdd [
	figure model: BormState new.
	view add: figure.
	self assert: view elements asSet equals: {figure} asSet , figure ownedElements
]

{ #category : #'as yet unclassified' }
OPBormStateFigureTest >> testRemove [
	figure model: BormState new.
	view add: figure.
	figure remove.
	self assert: view elements asArray equals: #()
]

{ #category : #'as yet unclassified' }
OPBormStateFigureTest >> testRemove1 [
	figure
		model:
			(BormState new
				beInitial;
				beFinal).
	view add: figure.
	figure remove.
	self assert: view elements asArray equals: #()
]
