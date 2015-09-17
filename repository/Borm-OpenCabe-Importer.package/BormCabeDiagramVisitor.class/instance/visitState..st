visitor
visitState: aXMLElement
	| state |
	state := BormState named: (self entityNameFor: aXMLElement).
	(aXMLElement attributeAt: #start) = 'true'
		ifTrue: [ state beInitial ].
	(aXMLElement attributeAt: #final) = 'true'
		ifTrue: [ state beFinal ].
	entities at: (aXMLElement attributeAt: 'ID') put: state.
	(self ensureEntityFor: aXMLElement parent) add: state