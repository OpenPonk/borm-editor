private - processing
processSpecification: anArray
	dictionary at: anArray first ifPresent: [ :item | ^ item ].
	anArray first first = $p
		ifTrue: [ ^ self processParticipant: anArray ].
	anArray first first = $a
		ifTrue: [ ^ self processActivity: anArray ].
	anArray first first = $s
		ifTrue: [ ^ self processState: anArray ]