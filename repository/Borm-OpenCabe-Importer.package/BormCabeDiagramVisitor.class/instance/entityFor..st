accessing
entityFor: aXMLElement
	^ self resolve: (aXMLElement xPath: 'entity/@href') stringValue