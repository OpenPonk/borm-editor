Class {
	#name : #BormActivityFigure,
	#superclass : #BormNodeFigure,
	#category : #'OpenPonk-BormEditor-Visuals'
}

{ #category : #'as yet unclassified' }
BormActivityFigure >> baseShape [
	^ self figuresFactory newRoundedBox
		width: self defaultSize x;
		height: self defaultSize y;
		color: (Color fromHexString: 'f2f2f2');
		yourself
]
