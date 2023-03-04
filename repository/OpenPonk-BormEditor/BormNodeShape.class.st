Class {
	#name : #BormNodeShape,
	#superclass : #BormShape,
	#instVars : [
		'text',
		'plusIcon',
		'plusIconAction'
	],
	#category : #'OpenPonk-BormEditor-Visuals'
}

{ #category : #defaults }
BormNodeShape >> defaultSize [
	^ 150 @ 60
]

{ #category : #initialization }
BormNodeShape >> initialize [

	super initialize.
	plusIconAction := [  ]
]

{ #category : #accessing }
BormNodeShape >> plusIcon [
	^ plusIcon
]

{ #category : #accessing }
BormNodeShape >> plusIconAction: aBlock [

	plusIconAction := aBlock
]

{ #category : #'as yet unclassified' }
BormNodeShape >> renderShapeDetails [

	| block |
	text := self shapesFactory newMultilineLabel
		        model: self;
		        yourself.
	self canvas add: text.
	block := [ self updateText ].
	self roassalShape
		when: RSPositionChangedEvent do: block;
		when: RSExtentChangedEvent do: block.
	plusIcon := RSBitmap new
		            form: (self iconNamed: #add);
		            when: RSMouseLeftClick do: plusIconAction;
		            yourself.
	RSLocation new
		right;
		bottom;
		offset: 5;
		stick: plusIcon on: self.

	self roassalShape @ OPRSSelectable.
	self roassalShape @ OPRSSelectionDraggable.
	self roassalShape @ OPRSResizable
]

{ #category : #accessing }
BormNodeShape >> text [
	^ text
]

{ #category : #'creating - subelements' }
BormNodeShape >> textOffset [
	^ 0 @ 0
]

{ #category : #'creating - subelements' }
BormNodeShape >> textPadding [

	self flag: #unused.
	^ 8
]

{ #category : #updating }
BormNodeShape >> updateRenderFromModel [

	self model submodel
		ifNil: [ plusIcon isInACanvas ifTrue: [ plusIcon remove ] ]
		ifNotNil: [ 
		plusIcon isInACanvas ifFalse: [ self canvas add: plusIcon ] ].
	self updateText.
	super updateRenderFromModel.
	roassalShape signalUpdate
]

{ #category : #updating }
BormNodeShape >> updateText [

	text text: self modelElement name.
	text translateTo: self position + self textOffset
]
