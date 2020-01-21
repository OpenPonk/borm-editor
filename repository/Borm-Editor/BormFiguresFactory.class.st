Class {
	#name : #BormFiguresFactory,
	#superclass : #Object,
	#category : 'Borm-Editor-Visuals'
}

{ #category : #'as yet unclassified' }
BormFiguresFactory >> activityFigure [
	| box label plus |
	box := self newRoundedBox
		width: 100;
		height: 400;
		color: (Color fromHexString: 'f2f2f2');
		element.
	label := self newLabel element.
	(RTConstraint on: label background: box) stick.
	plus := RTBitmap new
		form: Smalltalk ui icons smallAddIcon;
		element.
	(RTConstraint on: plus background: box)
		right;
		bottom;
		padding: 5;
		stick.
	box addCallback: (TRRemoveCallback with: label with: plus).
	box @ RTDraggableSnapToGrid @ RTResizable.
	^ box
]

{ #category : #'as yet unclassified' }
BormFiguresFactory >> backgroundColor [
	^ Color white
]

{ #category : #'as yet unclassified' }
BormFiguresFactory >> borderColor [
	^ Color black
]

{ #category : #'as yet unclassified' }
BormFiguresFactory >> newBox [
	^ RTBox new
		color: self backgroundColor;
		borderColor: self borderColor;
		yourself
]

{ #category : #'as yet unclassified' }
BormFiguresFactory >> newLabel [
	^ RTLabel new
		height: 10;
		color: self textColor;
		yourself
]

{ #category : #'as yet unclassified' }
BormFiguresFactory >> newRoundedBox [
	^ RTRoundedBox new
		color: self backgroundColor;
		borderColor: self borderColor;
		borderRadius: 20;
		yourself
]

{ #category : #'as yet unclassified' }
BormFiguresFactory >> newText [
	^ RTText new
		fontSize: 10;
		color: self textColor;
		yourself
]

{ #category : #'as yet unclassified' }
BormFiguresFactory >> textColor [
	^ Color black
]
