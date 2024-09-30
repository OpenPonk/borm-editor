Class {
	#name : 'BormConstraintShape',
	#superclass : 'OPEdgeLabel',
	#category : 'OpenPonk-BormEditor-Shapes',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Shapes'
}

{ #category : 'adding' }
BormConstraintShape >> anchorToEdge [

	OPRSAnchorConstraint new
		alwaysShowGuideLine;
		minDistanceToLine: self defaultMinDistance;
		positionReference: self defaultAnchorConstraintPosition;
		stick: roassalShape on: self owningElement roassalShape
]

{ #category : 'adding' }
BormConstraintShape >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : 'accessing' }
BormConstraintShape >> defaultFontSize [

	^ 12
]

{ #category : 'adding' }
BormConstraintShape >> defaultMinDistance [

	^ 10
]

{ #category : 'rendering' }
BormConstraintShape >> defaultText [

	^ self modelElement name ifEmpty: [ 'condition' ]
]

{ #category : 'adding' }
BormConstraintShape >> selectableInteraction [

	^ OPRSSelectable highlightColorBlue
]

{ #category : 'adding' }
BormConstraintShape >> shouldBePositionableByUser [

	^ true
]
