visitor
visitCommunication: aXMLElement
	| communication |
	communication := BormFactory
		communicationFrom: (self ensureEntityFor: aXMLElement parent)
		to:
			(self
				ensureEntityFor: (self resolve: (aXMLElement attributeAt: #target))).
	entities at: aXMLElement put: communication