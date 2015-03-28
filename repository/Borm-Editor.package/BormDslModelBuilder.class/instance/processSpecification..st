private - processing
processSpecification: anArray
	(anArray first includes: $.)
		ifTrue: [ ^ self processSubActivity: anArray ].
	anArray first first = $p
		ifTrue: [ ^ self processParticipant: anArray ].
	anArray first first = $a
		ifTrue: [ ^ self processActivity: anArray ].
	anArray first first = $s
		ifTrue: [ ^ self processState: anArray ]