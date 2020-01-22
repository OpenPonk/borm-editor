Class {
	#name : #BormNavigatorElements,
	#superclass : #BormNavigatorNode,
	#category : #'OpenPonk-BormEditor-Adapters'
}

{ #category : #'as yet unclassified' }
BormNavigatorElements >> children [
	^ model participants
]
