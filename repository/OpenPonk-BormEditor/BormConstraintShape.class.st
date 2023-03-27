Class {
	#name : #BormConstraintShape,
	#superclass : #OPEdgeLabel,
	#category : #'OpenPonk-BormEditor-DiagramElements'
}

{ #category : #adding }
BormConstraintShape >> addInteractions [

	| selectable |
	selectable := OPRSSelectable new.
	selectable highlightColor: Color blue.
	roassalShape @ selectable.
	roassalShape @ OPRSSelectionDraggable
]

{ #category : #adding }
BormConstraintShape >> anchorToEdge [

	OPRSAnchorConstraint new
		alwaysShowGuideLine;
		minDistanceToLine: self defaultMinDistance;
		positionReference: self defaultAnchorConstraintPosition;
		stick: roassalShape on: self owningElement roassalShape
]

{ #category : #adding }
BormConstraintShape >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : #accessing }
BormConstraintShape >> defaultFontSize [

	^ 12
]

{ #category : #adding }
BormConstraintShape >> defaultMinDistance [

	^ 10
]

{ #category : #rendering }
BormConstraintShape >> defaultText [

	^ self modelElement name ifEmpty: [ 'condition' ]
]
