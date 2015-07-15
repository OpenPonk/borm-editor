*Borm-Editor-DslParser
asBorm: aDiagramName
	^ (BormLangParser new parse: self)
		name: aDiagramName;
		yourself