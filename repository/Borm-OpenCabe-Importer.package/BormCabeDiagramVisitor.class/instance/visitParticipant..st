visitor
visitParticipant: aXMLElement
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