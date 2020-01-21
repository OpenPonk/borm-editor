Extension { #name : #String }

{ #category : #'*Borm-Editor-DslParser' }
String >> asBorm [
	^ self asBorm: ''
]

{ #category : #'*Borm-Editor-DslParser' }
String >> asBorm: aDiagramName [
	^ (BormLangParser new parse: self)
		name: aDiagramName;
		yourself
]
