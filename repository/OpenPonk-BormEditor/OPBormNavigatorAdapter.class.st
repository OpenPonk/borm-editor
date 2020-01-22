"
I implement specific mappings for BORM model
"
Class {
	#name : #OPBormNavigatorAdapter,
	#superclass : #OPNavigatorAdapter,
	#instVars : [
		'modelChildren'
	],
	#category : #'OpenPonk-BormEditor-Adapters'
}

{ #category : #private }
OPBormNavigatorAdapter >> bormNameFor: anObject [
	^ (anObject className splitOn: 'Borm') last
]

{ #category : #'widget API' }
OPBormNavigatorAdapter >> childrenForModel: aModel [
	"Always recreationg the BormNavigator* nodes will close the tree on change, so we need to cache it."
	^ modelChildren
		ifNil: [ modelChildren := Array
				with: (OPBormNavigatorElements new model: aModel)
				with: (OPBormNavigatorEntities new model: aModel) ]
]

{ #category : #'widget API' }
OPBormNavigatorAdapter >> childrenMapping [
	^ {BormORModel -> [ :m | self childrenForModel: m ].
	BormEntity -> #representations.
	OPBormNavigatorNode -> #children.
	BormParticipant -> #nodes.
	BormState -> #outgoing.
	BormActivity -> [ :o | o outgoing , o sent ].
	BormCommunication
		-> [ :o | o dataFlows , (o constraint ifNil: [ #() ] ifNotNil: [ {o constraint} ]) ].
	BormTransition -> [ :o | o constraint ifNil: [ #() ] ifNotNil: [ {o constraint} ] ]}
]

{ #category : #'widget API' }
OPBormNavigatorAdapter >> displayMapping [
	^ {OPBormNavigatorNode -> [ :o | (o className splitOn: 'BormNavigator') last  ].
	OPModelObject -> [ :o | self bormNameFor: o ]}
]

{ #category : #testing }
OPBormNavigatorAdapter >> hasMappingFor: anObject [
	^ anObject className beginsWith: 'Borm'
]

{ #category : #'widget API' }
OPBormNavigatorAdapter >> iconMapping [
	^ Array
		with: OPBormNavigatorEntities -> OPBormEditorIcons current entity16Icon
		with: OPBormNavigatorNode -> [ :o | Smalltalk ui icons addIcon ]
		with:
			OPModelObject
				->
					[ :o | OPBormEditorIcons current perform: ((self bormNameFor: o) uncapitalized , '16Icon') asSymbol ]
]
