private - processing
processBlock: anArray
	anArray do: [ :line | self processLine: line ].
	dictionary values do: [ :each | participant add: each ]