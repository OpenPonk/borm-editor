"
I am a navigator tree node representing a folder or collection of semantic BORM entities in the project tree.
"
Class {
	#name : 'OPBormNavigatorEntities',
	#superclass : 'OPBormNavigatorNode',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPBormNavigatorEntities >> children [
	^ model project allBormEntities
]
