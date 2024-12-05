Class {
	#name : 'BormCommunicationShape',
	#superclass : 'BormAssociationShape',
	#category : 'OpenPonk-BormEditor-DiagramElements',
	#package : 'OpenPonk-BormEditor',
	#tag : 'DiagramElements'
}

{ #category : 'constants' }
BormCommunicationShape >> marker [

	^ OPRSMarkerBuilder arrow
]
