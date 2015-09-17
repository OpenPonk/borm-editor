private - importing
importDiagram: aXMLDocument
	| importer |
	importer := BormCabeDiagramVisitor new.
	importer entities: self entities.
	importer visitDocument: aXMLDocument.
	project addDiagram: importer diagram