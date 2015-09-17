visitor
visitORTransition: aXMLElement
	| transition |
	transition := BormFactory
		transitionFrom: (self ensureEntityFor: aXMLElement parent)
		to: (self ensureEntityFor: (self resolve: (aXMLElement attributeAt: #target))).
	((aXMLElement / 'constraint') @ 'condition') stringValue
		ifNotEmpty: [ :condition | transition constraint: (BormConstraint named: condition) ].
	^ transition