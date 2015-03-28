private - processing
processDiagram: anArray
	anArray do: [ :block | self processParticipant: block ].
	anArray do: [ :block | self processBlock: block ].
	participants values do: [ :each | diagram add: each ].
	^ diagram