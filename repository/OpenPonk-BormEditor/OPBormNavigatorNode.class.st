"
I am an abstract base UI node for the OpenPonk project navigator, wrapping a BORM model element for hierarchical tree display.
"
Class {
	#name : 'OPBormNavigatorNode',
	#superclass : 'Object',
	#instVars : [
		'model'
	],
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPBormNavigatorNode >> model [
	^ model
]

{ #category : 'accessing' }
OPBormNavigatorNode >> model: anObject [
	model := anObject
]

{ #category : 'accessing' }
OPBormNavigatorNode >> name [
	^ ''
]
