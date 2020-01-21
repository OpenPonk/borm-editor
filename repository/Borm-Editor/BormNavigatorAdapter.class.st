"
I implement specific mappings for BORM model
"
Class {
	#name : #BormNavigatorAdapter,
	#superclass : #OPNavigatorAdapter,
	#instVars : [
		'modelChildren'
	],
	#category : 'Borm-Editor-Adapters'
}

{ #category : #private }
BormNavigatorAdapter >> bormNameFor: anObject [
	^ (anObject className splitOn: 'Borm') last
]

{ #category : #'widget API' }
BormNavigatorAdapter >> childrenForModel: aModel [
	"Always recreationg the BormNavigator* nodes will close the tree on change, so we need to cache it."
	^ modelChildren
		ifNil: [ modelChildren := Array
				with: (BormNavigatorElements new model: aModel)
				with: (BormNavigatorEntities new model: aModel) ]
]

{ #category : #'widget API' }
BormNavigatorAdapter >> childrenMapping [
	^ {BormORModel -> [ :m | self childrenForModel: m ].
	BormEntity -> #representations.
	BormNavigatorNode -> #children.
	BormParticipant -> #nodes.
	BormState -> #outgoing.
	BormActivity -> [ :o | o outgoing , o sent ].
	BormCommunication
		-> [ :o | o dataFlows , (o constraint ifNil: [ #() ] ifNotNil: [ {o constraint} ]) ].
	BormTransition -> [ :o | o constraint ifNil: [ #() ] ifNotNil: [ {o constraint} ] ]}
]

{ #category : #'widget API' }
BormNavigatorAdapter >> displayMapping [
	^ {BormNavigatorNode -> [ :o | (o className splitOn: 'BormNavigator') last  ].
	OPModelObject -> [ :o | self bormNameFor: o ]}
]

{ #category : #testing }
BormNavigatorAdapter >> hasMappingFor: anObject [
	^ anObject className beginsWith: 'Borm'
]

{ #category : #'widget API' }
BormNavigatorAdapter >> iconMapping [
	^ Array
		with: BormNavigatorEntities -> BormEditorIcons current entity16Icon
		with: BormNavigatorNode -> [ :o | Smalltalk ui icons addIcon ]
		with:
			OPModelObject
				->
					[ :o | BormEditorIcons current perform: ((self bormNameFor: o) uncapitalized , '16Icon') asSymbol ]
]
