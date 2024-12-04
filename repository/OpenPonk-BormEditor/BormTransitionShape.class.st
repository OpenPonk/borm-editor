Class {
	#name : 'BormTransitionShape',
	#superclass : 'BormAssociationShape',
	#category : 'OpenPonk-BormEditor-DiagramElements',
	#package : 'OpenPonk-BormEditor',
	#tag : 'DiagramElements'
}

{ #category : 'constants' }
BormTransitionShape >> marker [

	self modelElement ifNotNil: [ :model |
		(model target isKindOf: BormState) ifTrue: [
			^ OPRSMarkerBuilder triangle ] ].
	^ nil
]
