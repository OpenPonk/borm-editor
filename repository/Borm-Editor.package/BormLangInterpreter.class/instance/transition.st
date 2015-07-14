accessing
transition
	^ super transition
		==> [ :arr | 
			| t |
			t := BormTransition new.
			arr second ifNotNil: [ t constraint: arr second ].
			t target: arr first.
			t ]