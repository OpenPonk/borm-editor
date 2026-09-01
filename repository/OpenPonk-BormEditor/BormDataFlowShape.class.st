"
I am a visual node shape representing a BORM Data Flow. I act as an adornment attached to a communication edge, displaying the data flow label and directional indicators.
"
Class {
	#name : 'BormDataFlowShape',
	#superclass : 'OPBoundNode',
	#category : 'OpenPonk-BormEditor-DiagramElements',
	#package : 'OpenPonk-BormEditor',
	#tag : 'DiagramElements'
}

{ #category : 'adding' }
BormDataFlowShape >> anchorToEdge [

	"inspired by OPEdgeLabel"

	OPRSAnchorConstraint new
		alwaysShowGuideLine;
		minDistanceToLine: self defaultMinDistance;
		positionReference: self defaultAnchorConstraintPosition;
		stick: roassalShape on: self owningElement roassalShape
]

{ #category : 'initialization' }
BormDataFlowShape >> createOwnedElementsWithoutController [

	self ownedElements ifNotEmpty: [ ^ self ].
	BormDataFlowLabel in: self.
	BormDataFlowIcon in: self
]

{ #category : 'adding' }
BormDataFlowShape >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : 'adding' }
BormDataFlowShape >> defaultMinDistance [

	^ 10
]

{ #category : 'accessing' }
BormDataFlowShape >> icon [

	^ self ownedElements second
]

{ #category : 'accessing' }
BormDataFlowShape >> label [

	^ self ownedElements first
]

{ #category : 'rendering' }
BormDataFlowShape >> renderBasicShape [

	^ RSBox new
		  width: 40;
		  height: 35;
		  color: Color transparent;
		  borderColor: Color veryLightGray
]

{ #category : 'rendering' }
BormDataFlowShape >> renderShapeDetails [

	super renderShapeDetails.

	self anchorToEdge
]

{ #category : 'interactions' }
BormDataFlowShape >> selectableInteraction [

	^ OPRSSelectable highlightBorderColorBlue
]

{ #category : 'rendering' }
BormDataFlowShape >> updateRenderFromModel [

	super updateRenderFromModel.
	roassalShape width:
		(self label width max: self icon width) rounded + 6
]
