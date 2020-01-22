Class {
	#name : #OPBormNavigatorNode,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'OpenPonk-BormEditor-Adapters'
}

{ #category : #accessing }
OPBormNavigatorNode >> model [
	^ model
]

{ #category : #accessing }
OPBormNavigatorNode >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
OPBormNavigatorNode >> name [
	^ ''
]
