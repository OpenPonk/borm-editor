accessing
state
	^ super state
		==> [ :arr | 
			| s |
			s := BormState named: arr third key.
			arr second
				ifNotNil: [ 
					arr second = 'final'
						ifTrue: [ s beFinal ].
					arr second = 'initial'
						ifTrue: [ s beInitial ] ].
			s ]