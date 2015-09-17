visitor
visitActivity: aXMLElement
	| activity |
	activity := BormActivity named: (self entityNameFor: aXMLElement).
	entities at: (aXMLElement attributeAt: 'ID') put: activity.
	(self ensureEntityFor: aXMLElement parent) add: activity