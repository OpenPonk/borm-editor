Class {
	#name : #BormNavigatorElements,
	#superclass : #BormNavigatorNode,
	#category : 'Borm-Editor-Adapters'
}

{ #category : #'as yet unclassified' }
BormNavigatorElements >> children [
	^ model participants
]
