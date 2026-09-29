"
I am an edge label shape representing a BORM Constraint. I attach to transitions or communications and display the condition text.
"
Class {
	#name : 'BormConstraintShape',
	#superclass : 'OPEdgeLabel',
	#category : 'OpenPonk-BormEditor-DiagramElements',
	#package : 'OpenPonk-BormEditor',
	#tag : 'DiagramElements'
}

{ #category : 'adding' }
BormConstraintShape >> anchorToEdge [

	OPRSAnchorConstraint new
		alwaysShowGuideLine;
		minDistanceToLine: self defaultMinDistance;
		positionReference: self defaultAnchorConstraintPosition;
		stick: roassalShape on: self owningElement roassalShape
]

{ #category : 'accessing' }
BormConstraintShape >> canHaveController [

	^ true
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

{ #category : 'accessing' }
BormConstraintShape >> defaultText [

	^ self modelElement name ifEmpty: [ 'condition' ]
]

{ #category : 'interactions' }
BormConstraintShape >> selectableInteraction [

	^ OPRSSelectable highlightColorBlue
]
