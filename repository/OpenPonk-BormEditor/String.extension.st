Extension { #name : #String }

{ #category : #'*OpenPonk-BormEditor-DslParser' }
String >> asBorm [
	^ self asBorm: ''
]

{ #category : #'*OpenPonk-BormEditor-DslParser' }
String >> asBorm: aDiagramName [
	^ (BormLangParser new parse: self)
		name: aDiagramName;
		yourself
]
