private - processing
processState: anArray
	| params state |
	params := anArray second.
	state := BormState new.
	state name: (self nameFrom: anArray).
	(params includes: 'initial')
		ifTrue: [ state beInitial ].
	(params includes: 'final')
		ifTrue: [ state beFinal ].
	dictionary at: anArray first put: state.
	^ state