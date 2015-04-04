*Borm-Editor-DslParser
asBorm: aDiagramName
	^ (BormDslModelBuilder new parse: self)
		name: aDiagramName;
		yourself