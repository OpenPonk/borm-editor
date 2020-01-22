Class {
	#name : #BormNavigatorNode,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'OpenPonk-BormEditor-Adapters'
}

{ #category : #accessing }
BormNavigatorNode >> model [
	^ model
]

{ #category : #accessing }
BormNavigatorNode >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
BormNavigatorNode >> name [
	^ ''
]
