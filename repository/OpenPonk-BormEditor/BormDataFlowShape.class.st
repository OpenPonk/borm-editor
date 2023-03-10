Class {
	#name : #BormDataFlowShape,
	#superclass : #OPShape,
	#category : #'OpenPonk-BormEditor-DiagramElements'
}

{ #category : #rendering }
BormDataFlowShape >> addInteractions [

	| selectable |
	selectable := OPRSSelectable new.
	selectable highlightBorderColor: Color blue.
	roassalShape @ selectable.
	roassalShape @ OPRSSelectionDraggable
]

{ #category : #'as yet unclassified' }
BormDataFlowShape >> anchorToEdge [

	"inspired by OPEdgeLabel"

	OPRSAnchorConstraint new
		alwaysShowGuideLine;
		minDistance: self defaultMinDistance;
		positionReference: self defaultAnchorConstraintPosition;
		stick: roassalShape on: self owningElement roassalShape
]

{ #category : #initialization }
BormDataFlowShape >> createOwnedElementsWithoutController [

	self ownedElements ifNotEmpty: [ ^ self ].
	BormDataFlowLabel in: self.
	BormDataFlowIcon in: self
]

{ #category : #'as yet unclassified' }
BormDataFlowShape >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : #'as yet unclassified' }
BormDataFlowShape >> defaultMinDistance [

	^ 10
]

{ #category : #accessing }
BormDataFlowShape >> icon [

	^ self ownedElements second
]

{ #category : #accessing }
BormDataFlowShape >> label [

	^ self ownedElements first
]

{ #category : #rendering }
BormDataFlowShape >> renderBasicShape [

	^ RSBox new
		  width: 40;
		  height: 35;
		  color: Color transparent;
		  borderColor: Color veryLightGray
]

{ #category : #rendering }
BormDataFlowShape >> renderShapeDetails [

	super renderShapeDetails.

	self addInteractions.
	self anchorToEdge
]

{ #category : #rendering }
BormDataFlowShape >> updateRenderFromModel [

	super updateRenderFromModel.
	roassalShape width:
		(self label width max: self icon width) rounded + 6
]
