Class {
	#name : #BormTransitionShape,
	#superclass : #BormAssociationShape,
	#category : #'OpenPonk-BormEditor-Shapes'
}

{ #category : #constants }
BormTransitionShape >> marker [

	(self modelElement target isKindOf: BormState) ifTrue: [ 
		^ OPRSMarkerBuilder triangle ].
	^ nil
]
