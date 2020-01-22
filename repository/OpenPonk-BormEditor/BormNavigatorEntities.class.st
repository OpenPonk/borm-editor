Class {
	#name : #BormNavigatorEntities,
	#superclass : #BormNavigatorNode,
	#category : #'OpenPonk-BormEditor-Adapters'
}

{ #category : #'as yet unclassified' }
BormNavigatorEntities >> children [
	^ model project allBormEntities
]
