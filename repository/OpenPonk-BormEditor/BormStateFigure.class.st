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
	self updateInnerBox.
	innerBox translateTo: self position ].
	self addCallback: (TRTranslationCallback block: block).
	self addCallback: (TRExtentCallback block: block)
]

{ #category : #updating }
BormStateFigure >> show: anElement if: aConditionBlock [
	| wasShown isShown |
	wasShown := anElement view isNotNil.
	super show: anElement if: aConditionBlock.
	isShown := anElement view isNotNil.
	wasShown == isShown
		ifFalse: [ self updateText ]
]

{ #category : #'creating - subelements' }
BormStateFigure >> textOffset [
	self model ifNil: [ ^ super textOffset ].
	self model isInitial
		ifTrue: [ ^ super textOffset - (10 @ 0) ].
	^ super textOffset
]

{ #category : #'creating - subelements' }
BormStateFigure >> textPadding [
	| padding |
	padding := super textPadding.
	self model ifNil: [ ^ padding ].
	self model isInitial
		ifTrue: [ padding := padding + 12 ].
	self model isFinal
		ifTrue: [ padding := padding
				+
					(self model isInitial
						ifTrue: [ 2 ]
						ifFalse: [ 4 ]) ].
	^ padding
]

{ #category : #'as yet unclassified' }
BormStateFigure >> update [
	self show: playIcon if: self model isInitial.
	self show: innerBox if: self model isFinal.
	super update.
	self updateInnerBox
]

{ #category : #'as yet unclassified' }
BormStateFigure >> updateInnerBox [
	innerBox
		width: self width - 10;
		height: self height - 10
]
