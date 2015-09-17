private - importing
importProject: aDocument
	project := DCProject new.
	self
		importEntities:
			(self
				resolvePath:
					((aDocument // #entityCollection) first attributeAt: #href)).
	aDocument // #diagrams
		do:
			[ :each | self importDiagram: (self resolvePath: (each attributeAt: #href)) ]