visitor
ensureEntityFor: aXMLElement
	(entities includesKey: (aXMLElement attributeAt: 'ID'))
		ifFalse: [ self visit: aXMLElement ].
	^ entities at: (aXMLElement attributeAt: 'ID')