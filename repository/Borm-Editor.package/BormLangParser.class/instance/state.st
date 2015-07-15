accessing
state
	^ super state
		map: [ :arr | 
			| s t |
			t := arr first.
			s := BormState named: arr second key.
			nodesLookup at: arr second value put: s.
			t
				ifNotNil: [ 
					t = 'initial'
						ifTrue: [ s beInitial ].
					t = 'final'
						ifTrue: [ s beFinal ].
					t = 'initial and final'
						ifTrue: [ 
							s
								beInitial;
								beFinal ] ].
			s ]