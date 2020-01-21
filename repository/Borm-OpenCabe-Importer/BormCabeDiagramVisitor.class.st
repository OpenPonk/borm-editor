Class {
	#name : #BormCabeDiagramVisitor,
	#superclass : #Object,
	#instVars : [
		'entityNames',
		'entities',
		'diagram',
		'document'
	],
	#category : 'Borm-OpenCabe-Importer-Importer'
}

{ #category : #accessing }
BormCabeDiagramVisitor >> diagram [
	^ diagram
]

{ #category : #visitor }
BormCabeDiagramVisitor >> ensureEntityFor: aXMLElement [
	(entities includesKey: (aXMLElement attributeAt: 'ID'))
		ifFalse: [ self visit: aXMLElement ].
	^ entities at: (aXMLElement attributeAt: 'ID')
]

{ #category : #accessing }
BormCabeDiagramVisitor >> entities: aDictionary [
	entityNames := aDictionary
]

{ #category : #accessing }
BormCabeDiagramVisitor >> entityFor: aXMLElement [
	^ self resolve: (aXMLElement xPath: 'entity/@href') stringValue
]

{ #category : #accessing }
BormCabeDiagramVisitor >> entityNameFor: aXMLElement [
	^ (self entityFor: aXMLElement) at: #name
]

{ #category : #'as yet unclassified' }
BormCabeDiagramVisitor >> parseFragment: aString [
	| rx parts |
	rx := '//?([^/])+' asRegex.
	^ rx
		matchesIn: aString
		collect:
			[ :each | 
			parts := each splitOn: $..
			{(parts first copyWithoutAll: #//@).
			(parts second asNumber + 1)} ]
]

{ #category : #'as yet unclassified' }
BormCabeDiagramVisitor >> resolve: aString [
	| uri fragment selector position |
	uri := XMLURI fromString: aString.
	uri pathSegments last = 'entities.xmi'
		ifTrue:
			[ 
			fragment := $. split: uri fragment.
			selector := fragment first.
			position := fragment last asNumber.
			^ entityNames at: position + 1 ].
	^ self resolveFragment: aString
]

{ #category : #'as yet unclassified' }
BormCabeDiagramVisitor >> resolveFragment: aString [
	| fragment first element |
	fragment := self parseFragment: aString.
	first := fragment removeFirst.
	element := (document xPath: '*/' , first first) at: first second.
	fragment do: [ :each | element := element / each first at: each second ].
	^ element
]

{ #category : #visitor }
BormCabeDiagramVisitor >> visit: aXMLElement [
	| selector |
	(aXMLElement includesAttribute: 'xsi:type')
		ifFalse: [ ^ self ].
	selector := 'visit' , ((aXMLElement attributeAt: 'xsi:type') splitOn: $:) last , ':'.

	entities
		at: (aXMLElement attributeAt: 'ID')
		ifAbsent: [ self perform: selector asSymbol with: aXMLElement ]
]

{ #category : #visitor }
BormCabeDiagramVisitor >> visitActivity: aXMLElement [
	| activity |
	activity := BormActivity named: (self entityNameFor: aXMLElement).
	entities at: (aXMLElement attributeAt: 'ID') put: activity.
	(self ensureEntityFor: aXMLElement parent) add: activity
]

{ #category : #visitor }
BormCabeDiagramVisitor >> visitCommunication: aXMLElement [
	| communication |
	communication := BormFactory
		communicationFrom: (self ensureEntityFor: aXMLElement parent)
		to:
			(self
				ensureEntityFor: (self resolve: (aXMLElement attributeAt: #target))).
	entities at: aXMLElement put: communication
]

{ #category : #visitor }
BormCabeDiagramVisitor >> visitDataFlow: aXMLElement [
	| flow |
	(entities includesKey: aXMLElement parent)
		ifFalse: [ self visit: aXMLElement parent ].
	flow := BormDataFlow named: (self entityNameFor: aXMLElement).
	(aXMLElement attributeAt: 'input') = 'true'
		ifTrue: [ flow beInput ]
		ifFalse: [ flow beOutput ].
	(entities at: aXMLElement parent) addDataFlow: flow
]

{ #category : #visitor }
BormCabeDiagramVisitor >> visitDocument: aXMLDocument [
	document := aXMLDocument.
	entities := Dictionary new.
	diagram := BormDiagram new.
	diagram name: (self entityNameFor: aXMLDocument root).
	aXMLDocument root allElementsDo: [ :each | self visit: each ]
]

{ #category : #visitor }
BormCabeDiagramVisitor >> visitORTransition: aXMLElement [
	| transition |
	transition := BormFactory
		transitionFrom: (self ensureEntityFor: aXMLElement parent)
		to: (self ensureEntityFor: (self resolve: (aXMLElement attributeAt: #target))).
	((aXMLElement / 'constraint') @ 'condition') stringValue
		ifNotEmpty: [ :condition | transition constraint: (BormConstraint named: condition) ].
	^ transition
]

{ #category : #visitor }
BormCabeDiagramVisitor >> visitParticipant: aXMLElement [
	| participant |
	participant := BormParticipant new.
	participant name: (self entityNameFor: aXMLElement).
	(aXMLElement attributeAt: 'type')
		ifNotEmpty:
			[ :type | participant type: (BormParticipantType perform: type asLowercase capitalized asSymbol) ].
	(aXMLElement attributeAt: 'role')
		ifNotEmpty:
			[ :role | participant role: (BormParticipantRole perform: role asLowercase capitalized asSymbol) ].
	entities at: (aXMLElement attributeAt: 'ID') put: participant.
	diagram add: participant
]

{ #category : #visitor }
BormCabeDiagramVisitor >> visitState: aXMLElement [
	| state |
	state := BormState named: (self entityNameFor: aXMLElement).
	(aXMLElement attributeAt: #start) = 'true'
		ifTrue: [ state beInitial ].
	(aXMLElement attributeAt: #final) = 'true'
		ifTrue: [ state beFinal ].
	entities at: (aXMLElement attributeAt: 'ID') put: state.
	(self ensureEntityFor: aXMLElement parent) add: state
]
