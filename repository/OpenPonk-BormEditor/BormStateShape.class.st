Class {
	#name : #BormStateShape,
	#superclass : #BormNodeShape,
	#instVars : [
		'playIcon',
		'innerBox'
	],
	#category : #'OpenPonk-BormEditor-DiagramElements'
}

{ #category : #'as yet unclassified' }
BormStateShape >> renderBasicShape [

	^ self shapesFactory newRoundedBox
		  width: self defaultSize x;
		  height: self defaultSize y;
		  cornerRadius: 5;
		  yourself
]

{ #category : #'as yet unclassified' }
BormStateShape >> renderShapeDetails [

	| block |
	super renderShapeDetails.
	playIcon := RSBitmap new
		            form: OPBormEditorIcons initialIcon;
		            yourself.
	RSLocation new
		inner;
		right;
		offset: -5 @ 0;
		stick: playIcon on: self roassalShape.
	innerBox := self shapesFactory newBox
		            color: Color transparent;
		            yourself.
	block := [ 
	         self updateInnerBox.
	         innerBox translateTo: self position ].
	self roassalShape
		when: RSPositionChangedEvent do: block;
		when: RSExtentChangedEvent do: block
]

{ #category : #'creating - subelements' }
BormStateShape >> textOffset [

	self modelElement ifNil: [ ^ super textOffset ].
	self modelElement isInitial ifTrue: [ ^ super textOffset - (10 @ 0) ].
	^ super textOffset
]

{ #category : #'creating - subelements' }
BormStateShape >> textPadding [
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
BormStateShape >> updateInnerBox [
	innerBox
		width: self width - 10;
		height: self height - 10
]

{ #category : #'as yet unclassified' }
BormStateShape >> updateRenderFromModel [

	self modelElement isInitial
		ifTrue: [ 
		playIcon isInACanvas ifFalse: [ self canvas add: playIcon ] ]
		ifFalse: [ playIcon isInACanvas ifTrue: [ playIcon remove ] ].
	innerBox borderColor: (self modelElement isFinal
			 ifTrue: [ self shapesFactory borderColor ]
			 ifFalse: [ Color transparent ]).
	self updateInnerBox.
	super updateRenderFromModel
]
