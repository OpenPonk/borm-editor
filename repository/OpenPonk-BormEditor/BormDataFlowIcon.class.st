Class {
	#name : #BormDataFlowIcon,
	#superclass : #OPNode,
	#category : #'OpenPonk-BormEditor-DiagramElements'
}

{ #category : #rendering }
BormDataFlowIcon >> renderBasicShape [

	^ RSBitmap new
		  form: OPBormEditorIcons dataFlowRightIcon;
		  yourself
]

{ #category : #rendering }
BormDataFlowIcon >> renderShapeDetails [

	super renderShapeDetails.

	RSLocation new
		inner;
		bottom;
		offset: 0 @ -5;
		stick: roassalShape on: self owningElement roassalShape.

	roassalShape
		when: RSPositionChangedEvent
		do: [ self updateRenderFromModel ]
]

{ #category : #rendering }
BormDataFlowIcon >> updateRenderFromModel [

	| constraintShape right |
	super updateRenderFromModel.

	constraintShape := self owningElement owningElement.
	right := constraintShape source position x
	         < constraintShape target position x.
	self modelElement isOutput ifTrue: [ right := right not ].
	roassalShape form: (right
			 ifTrue: [ OPBormEditorIcons dataFlowRightIcon ]
			 ifFalse: [ OPBormEditorIcons dataFlowLeftIcon ]).

	roassalShape signalUpdate
]
