"
I am a text label shape specifically designed to display the name of a BORM Data Flow on the diagram canvas.
"
Class {
	#name : 'BormDataFlowLabel',
	#superclass : 'OPLabel',
	#category : 'OpenPonk-BormEditor-DiagramElements',
	#package : 'OpenPonk-BormEditor',
	#tag : 'DiagramElements'
}

{ #category : 'accessing' }
BormDataFlowLabel >> defaultText [

	^ self modelElement name
]

{ #category : 'rendering' }
BormDataFlowLabel >> renderShapeDetails [

	| location |
	super renderShapeDetails.

	location := RSLocation new
		inner;
		top;
		yourself.
	location stick: roassalShape on: self owningElement roassalShape.
	roassalShape
		when: RSExtentChangedEvent
		do: [ :theExtentEvent |
			location move: roassalShape on: self owningElement roassalShape ]
		for: self
]

{ #category : 'testing' }
BormDataFlowLabel >> shouldBePositionableByUser [
	^ false
]
