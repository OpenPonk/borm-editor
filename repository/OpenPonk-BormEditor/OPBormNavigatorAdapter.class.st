"
I implement specific mappings for BORM model
"
Class {
	#name : 'OPBormNavigatorAdapter',
	#superclass : 'OPNavigatorAdapter',
	#instVars : [
		'modelChildren'
	],
	#category : 'OpenPonk-BormEditor-Adapters',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Adapters'
}

{ #category : 'accessing' }
OPBormNavigatorAdapter class >> priority [

	^ 10
]

{ #category : 'private' }
OPBormNavigatorAdapter >> bormNameFor: anObject [
	^ (anObject className splitOn: 'Borm') last
]

{ #category : 'widget API' }
OPBormNavigatorAdapter >> childrenMapping [
	^ {(BormORModel -> #participants).
	(BormEntity -> #representations).
	(OPBormNavigatorNode -> #children).
	(BormParticipant -> #nodes).
	(BormState -> [ :o | o transitions ]).
	(BormActivity -> [ :o | o transitions , o communications ]).
	(BormCommunication -> [ :o | o dataFlows , o constraints ]).
	(BormTransition -> [ :o | o constraints ])}
]

{ #category : 'widget API' }
OPBormNavigatorAdapter >> displayMapping [
	^ {OPBormNavigatorNode -> [ :o | (o className splitOn: 'BormNavigator') last  ].
	OPModelObject -> [ :o | self bormNameFor: o ]}
]

{ #category : 'testing' }
OPBormNavigatorAdapter >> hasMappingFor: anObject in: aModel [

	^ { 
		  BormElement.
		  BormEntity.
		  BormParticipantRole.
		  BormParticipantType } anySatisfy: [ :any | anObject isKindOf: any ]
]

{ #category : 'widget API' }
OPBormNavigatorAdapter >> iconMapping [
	^ Array
		with: OPBormNavigatorEntities -> OPBormEditorIcons entity16Icon
		with: OPBormNavigatorNode -> [ :o | self iconNamed: #addIcon ]
		with:
			OPModelObject
				-> [ :o | 
					OPBormEditorIcons
						perform: ((self bormNameFor: o) uncapitalized , '16Icon') asSymbol ]
]

{ #category : 'private' }
OPBormNavigatorAdapter >> sort: modelObjects [
	^ modelObjects
		sorted:
			[ :a :b | a name isNotNil and: [ b name isNil or: [ a name < b name ] ] ]
]

{ #category : 'widget API' }
OPBormNavigatorAdapter >> typesByDependency [
	^ {BormORModel.
	BormParticipant.
	BormProcessNode.
	BormTransition.
	BormCommunication.
	BormDataFlow.
	BormConstraint}
]
