Class {
	#name : #BormNavigatorNode,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : 'Borm-Editor-Adapters'
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
