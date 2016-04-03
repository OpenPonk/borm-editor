parsing
replaceModel: aModel withStatements: parsedModel
	aModel elements reset.
	parsedModel elements do: [ :each | aModel add: each ]