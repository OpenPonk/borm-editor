Class {
	#name : #BormNodeShape,
	#superclass : #BormShape,
	#instVars : [
		'shapesFactory',
		'plusIcon',
		'plusIconAction',
		'labeled',
		'wrappedForWidth'
	],
	#category : #'OpenPonk-BormEditor-Shapes'
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

	labeled := OPRSLabeled new.
	labeled color: Color black.
	labeled shapeBuilder wrapStrategy:
		(RSWrapStrategy new wrapMaxWidth: self wrapMaxWidth).
	labeled location
		inner;
		center;
		middle;
		offset: self textOffset.
	roassalShape @ labeled.


	self roassalShape
		when: RSExtentChangedEvent
		do: [ :event |
			(event newExtent x closeTo: wrappedForWidth absolutePrecision: 0.99)
				ifFalse: [ self updateText ] ]
		for: self.

	plusIcon := RSBitmap new
		            form: (self iconNamed: #add);
		            when: RSMouseLeftClick
		            do: plusIconAction
		            for: plusIconAction receiver;
		            yourself.
	RSLocation new
		right;
		bottom;
		offset: -5;
		stick: plusIcon on: roassalShape.
	roassalShape
		when: RSShapeRemovedEvent
		do: [ plusIcon remove ]
		for: self.
]

{ #category : #'as yet unclassified' }
BormNodeShape >> selectableInteraction [

	^ OPRSSelectable highlightBorderColorBlue
]

{ #category : #accessing }
BormNodeShape >> shapesFactory [
	^ shapesFactory ifNil: [ shapesFactory := BormShapesFactory new ]
]

{ #category : #'as yet unclassified' }
BormNodeShape >> shouldBePositionableByUser [

	^ true
]

{ #category : #interactions }
BormNodeShape >> shouldBeResizableByUser [

	^ true
]

{ #category : #'creating - subelements' }
BormNodeShape >> textOffset [
	^ 0 @ 0
]

{ #category : #'creating - subelements' }
BormNodeShape >> textPadding [

	^ 5
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

	wrappedForWidth := roassalShape width.

	labeled
		wrapMaxWidth: self wrapMaxWidth;
		text: self modelElement name.

	labeled labelShape height > roassalShape height ifTrue: [ 
		roassalShape height: labeled labelShape height + 10 ]
]

{ #category : #hooks }
BormNodeShape >> wrapMaxWidth [

	^ self width - (self textPadding * 2) max: 20
]
