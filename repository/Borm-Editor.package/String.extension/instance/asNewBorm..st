*Borm-Editor-DslParser
asNewBorm: aDiagramName
	^ (BormLangInterpreter new parse: self)
		name: aDiagramName;
		yourself