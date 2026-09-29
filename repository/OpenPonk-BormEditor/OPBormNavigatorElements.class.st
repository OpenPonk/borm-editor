"
I am a navigator tree node representing a folder or collection of BORM diagram elements in the project tree.
"
Class {
	#name : 'OPBormNavigatorElements',
	#superclass : 'OPBormNavigatorNode',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPBormNavigatorElements >> children [
	^ model participants
]
