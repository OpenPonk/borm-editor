Class {
	#name : #BormNodeShape,
	#superclass : #BormShape,
	#instVars : [
		'shapesFactory',
		'plusIcon',
		'plusIconAction'
	],
	#category : #'OpenPonk-BormEditor-DiagramElements'
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

	| block labeled selectable |
	labeled := RSLabeled new.
	labeled shapeBuilder labelShape color: Color black.
	labeled location
		inner;
		center;
		middle;
		offset: self textOffset.
	roassalShape @ labeled.

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
		stick: plusIcon on: roassalShape.

	selectable := OPRSSelectable new.
	selectable highlightBorderColor: Color blue.
	roassalShape @ selectable.
	roassalShape @ OPRSSelectionDraggable @ OPRSResizable
]

{ #category : #accessing }
BormNodeShape >> shapesFactory [
	^ shapesFactory ifNil: [ shapesFactory := BormShapesFactory new ]
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

	self modelElement submodel
		ifNil: [ plusIcon isInACanvas ifTrue: [ plusIcon remove ] ]
		ifNotNil: [ 
		plusIcon isInACanvas ifFalse: [ self canvas add: plusIcon ] ].
	self updateText.
	super updateRenderFromModel.
	roassalShape signalUpdate
]

{ #category : #updating }
BormNodeShape >> updateText [

	(roassalShape propertyAt: #RSLabeled) text: self modelElement name
]
