Extension { #name : 'String' }

{ #category : '*OpenPonk-BormEditor-DslParser' }
String >> asBorm: aDiagramName [
	^ (BormLangParser new parse: self)
		name: aDiagramName;
		yourself
]
