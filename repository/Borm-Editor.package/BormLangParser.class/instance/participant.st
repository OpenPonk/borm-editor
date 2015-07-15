accessing
participant
	^ super participant
		==> [ :arr | 
			| p |
			p := BormParticipant new
				name: arr second key;
				type: arr first;
				yourself.
			"insert all nodes"
			arr third do: [ :each | p add: each ].
			"finish transitions"
			incompleteTransitions
				do: [ :each | 
					| n |
					n := nodesLookup at: each target.
					n addTransition: each.
					each target: n ].
			incompleteTransitions removeAll.
			participantsLookup at: arr second value put: nodesLookup.
			nodesLookup := Dictionary new.
			p ]