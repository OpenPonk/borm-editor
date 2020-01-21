Class {
	#name : #BormNavigatorEntities,
	#superclass : #BormNavigatorNode,
	#category : 'Borm-Editor-Adapters'
}

{ #category : #'as yet unclassified' }
BormNavigatorEntities >> children [
	^ model project allBormEntities
]
