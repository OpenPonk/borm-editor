Class {
	#name : #BormDataFlowLabel,
	#superclass : #OPLabel,
	#category : #'OpenPonk-BormEditor-DiagramElements'
}

{ #category : #accessing }
BormDataFlowLabel >> defaultText [

	^ self modelElement name
]

{ #category : #rendering }
BormDataFlowLabel >> renderShapeDetails [

	super renderShapeDetails.

	RSLocation new
		inner;
		top;
		stick: roassalShape on: self owningElement roassalShape
]