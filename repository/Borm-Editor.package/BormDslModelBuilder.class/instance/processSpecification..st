private - processing
processSpecification: anArray
	(anArray first includes: $.)
		ifTrue: [ ^ self processRemoteActivity: anArray ].
	anArray first first = $p
		ifTrue: [ ^ self processParticipant: anArray ].
	nodes at: anArray first ifPresent: [ :n | ^ n ].
	anArray first first = $a
		ifTrue: [ ^ self processActivity: anArray ].
	anArray first first = $s
		ifTrue: [ ^ self processState: anArray ]