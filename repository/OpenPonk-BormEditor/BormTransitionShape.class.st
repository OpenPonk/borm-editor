Class {
	#name : 'BormTransitionShape',
	#superclass : 'BormAssociationShape',
	#category : 'OpenPonk-BormEditor-Shapes',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Shapes'
}

{ #category : 'constants' }
BormTransitionShape >> marker [

	self modelElement ifNotNil: [ :model |
		(model target isKindOf: BormState) ifTrue: [
			^ OPRSMarkerBuilder triangle ] ].
	^ nil
]
