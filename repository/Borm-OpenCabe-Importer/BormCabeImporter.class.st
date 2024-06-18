Class {
	#name : 'BormCabeImporter',
	#superclass : 'Object',
	#instVars : [
		'entities',
		'root',
		'project'
	],
	#category : 'Borm-OpenCabe-Importer-Importer',
	#package : 'Borm-OpenCabe-Importer',
	#tag : 'Importer'
}

{ #category : 'importing' }
BormCabeImporter class >> importFile: aFileReference [
	^ self new importFile: aFileReference
]

{ #category : 'accessing' }
BormCabeImporter >> entities [
	^ entities
]

{ #category : 'retrieving' }
BormCabeImporter >> getDocument: aPath [
	^ self parseXml: (root resolve: aPath)
]

{ #category : 'private - importing' }
BormCabeImporter >> importDiagram: aXMLDocument [
	| importer |
	importer := BormCabeDiagramVisitor new.
	importer entities: self entities.
	importer visitDocument: aXMLDocument.
	project addDiagram: importer diagram
]

{ #category : 'private - importing' }
BormCabeImporter >> importEntities: aDocument [
	entities := aDocument // #entities collect: #attributes
]

{ #category : 'importing' }
BormCabeImporter >> importFile: aFileReference [
	root := (FileSystem zip: aFileReference) open workingDirectory.
	self importProject: (self getDocument: 'project.xmi')
]

{ #category : 'private - importing' }
BormCabeImporter >> importProject: aDocument [
	project := DCProject new.
	self
		importEntities:
			(self
				resolvePath:
					((aDocument // #entityCollection) first attributeAt: #href)).
	aDocument // #diagrams
		do:
			[ :each | self importDiagram: (self resolvePath: (each attributeAt: #href)) ]
]

{ #category : 'parsing' }
BormCabeImporter >> parseXml: aFile [
	^ XMLDOMParser parse: aFile
]

{ #category : 'accessing' }
BormCabeImporter >> project [
	^ project
]

{ #category : 'navigating' }
BormCabeImporter >> resolvePath: aString [
	| url |
	url := XMLURI fromString: aString.
	^ self getDocument: url path
]
