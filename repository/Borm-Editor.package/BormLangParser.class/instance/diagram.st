accessing
diagram
	^ super diagram
		==> [ :arr | 
			| d |
			d := BormORModel new.
			d addAll: arr.

			incompleteCommunications
				do: [ :each | 
					| n splitName |
					splitName := (each receiver splitOn: '::').
					n := (participantsLookup at: splitName first) at: splitName second.
					n receive: each.
					each receiver: n ].

			d ]