Class {
	#name : #BormNodeFigure,
	#superclass : #BormFigure,
	#instVars : [
		'text',
		'plusIcon'
	],
	#category : #'OpenPonk-BormEditor-Visuals'
}

{ #category : #rendering }
BormNodeFigure >> addInteractions [
	self @ OPRTDraggableSnapToGrid.
	self @ RTResizable
]

{ #category : #'creating - subelements' }
BormNodeFigure >> createOwnedElements [
	| block |
	text := self figuresFactory newText
		text: [ :m | m model ifNil: '' ifNotNil: #name ];
		wrapText;
		elementOn: self.
	self add: text.
	block := [ self updateText ].
	block value.
	self addCallback: (TRTranslationCallback block: block).
	self addCallback: (TRExtentCallback block: block).
	plusIcon := RTBitmap new
		form: (self iconNamed: #add);
		element.
	(RTConstraint on: plusIcon background: self)
		right;
		bottom;
		padding: 5;
		stick
]

{ #category : #defaults }
BormNodeFigure >> defaultSize [
	^ 150 @ 60
]

{ #category : #accessing }
BormNodeFigure >> plusIcon [
	^ plusIcon
]

{ #category : #accessing }
BormNodeFigure >> text [
	^ text
]

{ #category : #'creating - subelements' }
BormNodeFigure >> textOffset [
	^ 0 @ 0
]

{ #category : #'creating - subelements' }
BormNodeFigure >> textPadding [
	^ 8
]

{ #category : #updating }
BormNodeFigure >> update [
	self show: plusIcon if: self model submodel isNotNil.
	super update
]

{ #category : #updating }
BormNodeFigure >> updateText [
	text shape width: self width - (self textPadding * 2).
	text update.
	text translateTo: self position + self textOffset
]
