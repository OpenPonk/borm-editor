"
I am an edge shape representing a BORM Communication channel. I inherit association rendering behavior and apply specific markers to indicate inter-participant data exchange.
"
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
