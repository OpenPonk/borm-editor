converting
stateType: aState
	aState isInitial & aState isFinal
		ifTrue: [ ^ 'initial and final ' ].

	aState isInitial
		ifTrue: [ ^ 'initial ' ].

	aState isFinal
		ifTrue: [ ^ 'final ' ].

	^ ''