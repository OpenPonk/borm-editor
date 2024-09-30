Class {
	#name : 'OPBormNavigatorEntities',
	#superclass : 'OPBormNavigatorNode',
	#category : 'OpenPonk-BormEditor-Adapters',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Adapters'
}

{ #category : 'as yet unclassified' }
OPBormNavigatorEntities >> children [
	^ model project allBormEntities
]
