Class {
	#name : #BormTransitionShape,
	#superclass : #BormAssociationShape,
	#category : #'OpenPonk-BormEditor-DiagramElements'
}

{ #category : #constants }
BormTransitionShape >> marker [

	(self modelElement target isKindOf: BormState) ifTrue: [ 
		^ OPRSMarkerBuilder triangle ].
	^ nil
]
