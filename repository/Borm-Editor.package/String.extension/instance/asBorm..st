*Borm-Editor-DslParser
asBorm: aDiagramName
	^ (BormLangInterpreter new parse: self)
		name: aDiagramName;
		yourself