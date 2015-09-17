visitor
visitDocument: aXMLDocument
	document := aXMLDocument.
	entities := Dictionary new.
	diagram := BormDiagram new.
	diagram name: (self entityNameFor: aXMLDocument root).
	aXMLDocument root allElementsDo: [ :each | self visit: each ]