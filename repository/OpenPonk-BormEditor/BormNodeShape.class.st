Class {
	#name : 'BormNodeShape',
	#superclass : 'BormShape',
	#instVars : [
		'shapesFactory',
		'plusIcon',
		'plusIconAction',
		'labeled',
		'wrappedForWidth'
	],
	#category : 'OpenPonk-BormEditor-DiagramElements',
	#package : 'OpenPonk-BormEditor',
	#tag : 'DiagramElements'
}

{ #category : 'accessing' }
BormNodeShape >> attachedShapes [

	^ {
		  plusIcon.
		  (labeled ifNotNil: [ :l | l labelShape ]) }
]

{ #category : 'rendering' }
BormNodeShape >> defaultBackgroundColor [

	^ self shapesFactory backgroundColor
]

{ #category : 'defaults' }
BormNodeShape >> defaultSize [
	^ 150 @ 60
]

{ #category : 'initialization' }
BormNodeShape >> initialize [

	super initialize.
	plusIconAction := [  ]
]

{ #category : 'accessing' }
BormNodeShape >> plusIcon [
	^ plusIcon
]

{ #category : 'accessing' }
BormNodeShape >> plusIconAction: aBlock [

	plusIconAction := aBlock
]

{ #category : 'removing' }
BormNodeShape >> removeRender [

	super removeRender.
	plusIcon := nil.
	labeled := nil
]

{ #category : 'rendering' }
BormNodeShape >> renderBasicShape [

	^ self shapesFactory newRoundedBox
		  width: self defaultSize x;
		  height: self defaultSize y;
		  color: self defaultBackgroundColor;
		  yourself
]

{ #category : 'rendering' }
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
		stick: plusIcon on: roassalShape
]

{ #category : 'interactions' }
BormNodeShape >> selectableInteraction [

	^ OPRSSelectable highlightBorderColorBlue
]

{ #category : 'accessing' }
BormNodeShape >> shapesFactory [
	^ shapesFactory ifNil: [ shapesFactory := BormShapesFactory new ]
]

{ #category : 'interactions' }
BormNodeShape >> shouldBePositionableByUser [

	^ true
]

{ #category : 'interactions' }
BormNodeShape >> shouldBeResizableByUser [

	^ true
]

{ #category : 'creating - subelements' }
BormNodeShape >> textOffset [
	^ 0 @ 0
]

{ #category : 'creating - subelements' }
BormNodeShape >> textPadding [

	^ 5
]

{ #category : 'rendering' }
BormNodeShape >> updateRenderFromModel [

	self modelElement submodel
		ifNil: [ plusIcon isInACanvas ifTrue: [ plusIcon remove ] ]
		ifNotNil: [ 
		plusIcon isInACanvas ifFalse: [ self canvas add: plusIcon ] ].
	self updateText.
	super updateRenderFromModel.
	roassalShape signalUpdate
]

{ #category : 'rendering' }
BormNodeShape >> updateText [

	wrappedForWidth := roassalShape width.

	labeled
		wrapMaxWidth: self wrapMaxWidth;
		text: self modelElement name.

	labeled labelShape height > roassalShape height ifTrue: [ 
		roassalShape height: labeled labelShape height + 10 ]
]

{ #category : 'hooks' }
BormNodeShape >> wrapMaxWidth [

	^ self width - (self textPadding * 2) max: 20
]
