Class {
	#name : #BormStateFigure,
	#superclass : #BormNodeFigure,
	#instVars : [
		'playIcon',
		'innerBox'
	],
	#category : #'OpenPonk-BormEditor-Visuals'
}

{ #category : #'as yet unclassified' }
BormStateFigure >> baseShape [
	^ self figuresFactory newRoundedBox
		width: self defaultSize x;
		height: self defaultSize y;
		borderRadius: 5;
		yourself
]

{ #category : #'as yet unclassified' }
BormStateFigure >> createOwnedElements [
	| block |
	super createOwnedElements.
	playIcon := RTBitmap new
		form: OPBormEditorIcons current initialIcon;
		element.
	(RTConstraint on: playIcon background: self)
		right;
		padding: 5;
		stick.
	innerBox := self figuresFactory newBox
		color: Color transparent;
		element.
	block := [ :aShape :step | 
	innerBox
		width: self width - 10;
		height: self height - 10.
	innerBox translateTo: self position ].
	self addCallback: (TRTranslationCallback block: block).
	self addCallback: (TRExtentCallback block: block)
]

{ #category : #'as yet unclassified' }
BormStateFigure >> update [
	self show: playIcon if: self model isInitial.
	self show: innerBox if: self model isFinal.
	super update
]
