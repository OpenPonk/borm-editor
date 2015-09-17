visitor
visit: aXMLElement
	| selector |
	(aXMLElement includesAttribute: 'xsi:type')
		ifFalse: [ ^ self ].
	selector := 'visit' , ((aXMLElement attributeAt: 'xsi:type') splitOn: $:) last , ':'.

	entities
		at: (aXMLElement attributeAt: 'ID')
		ifAbsent: [ self perform: selector asSymbol with: aXMLElement ]