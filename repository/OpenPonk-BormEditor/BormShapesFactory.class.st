Class {
	#name : #BormShapesFactory,
	#superclass : #Object,
	#category : #'OpenPonk-BormEditor-DiagramElements'
}

{ #category : #'as yet unclassified' }
BormShapesFactory >> activityShape [

	| box label plus |
	box := self newRoundedBox
		       width: 100;
		       height: 400;
		       color: (Color fromHexString: 'f2f2f2');
		       yourself.
	label := self newMultilineLabel.
	RSLocation new stick: label on: box.
	plus := RSBitmap new
		        form: (self iconNamed: #smallAddIcon);
		        yourself.
	RSLocation new
		right;
		bottom;
		offset: 5;
		stick: plus on: box.
	box when: RSShapeRemovedEvent do: [ 
		label remove.
		plus remove ].
	box @ OPRSSelectionDraggable @ OPRSResizable.
	^ box
]

{ #category : #'as yet unclassified' }
BormShapesFactory >> backgroundColor [
	^ Color white
]

{ #category : #'as yet unclassified' }
BormShapesFactory >> borderColor [
	^ Color black
]

{ #category : #'as yet unclassified' }
BormShapesFactory >> newBox [

	^ RSBox new
		  color: self backgroundColor;
		  borderColor: self borderColor;
		  yourself
]

{ #category : #'as yet unclassified' }
BormShapesFactory >> newLabel [

	^ RSLabel new
		  height: 10;
		  color: self textColor;
		  yourself
]

{ #category : #'as yet unclassified' }
BormShapesFactory >> newMultilineLabel [

	self flag: #multiline.
	^ RSLabel new
		  fontSize: 10;
		  color: self textColor;
		  yourself
]

{ #category : #'as yet unclassified' }
BormShapesFactory >> newRoundedBox [

	^ RSBox new
		  color: self backgroundColor;
		  borderColor: self borderColor;
		  cornerRadius: 20;
		  yourself
]

{ #category : #'as yet unclassified' }
BormShapesFactory >> textColor [
	^ Color black
]
