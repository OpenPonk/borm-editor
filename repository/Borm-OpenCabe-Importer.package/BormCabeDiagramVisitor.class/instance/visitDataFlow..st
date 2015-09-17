visitor
visitDataFlow: aXMLElement
	| flow |
	(entities includesKey: aXMLElement parent)
		ifFalse: [ self visit: aXMLElement parent ].
	flow := BormDataFlow named: (self entityNameFor: aXMLElement).
	(aXMLElement attributeAt: 'input') = 'true'
		ifTrue: [ flow beInput ]
		ifFalse: [ flow beOutput ].
	(entities at: aXMLElement parent) addDataFlow: flow