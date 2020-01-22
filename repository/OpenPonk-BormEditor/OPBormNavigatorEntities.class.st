Class {
	#name : #OPBormNavigatorEntities,
	#superclass : #OPBormNavigatorNode,
	#category : #'OpenPonk-BormEditor-Adapters'
}

{ #category : #'as yet unclassified' }
OPBormNavigatorEntities >> children [
	^ model project allBormEntities
]
