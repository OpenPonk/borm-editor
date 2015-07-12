accessing
participant
	^ super participant
		==> [ :arr | 
			| p |
			p := BormParticipant new
				name: (arr at: #name) key;
				type: (arr at: #type);
				yourself.
			"insert all nodes"
			(arr at: #nodes) do: [ :nodeArr | p add: (nodeArr at: #node) ].
			"and transitions between them"
			(arr at: #nodes)
				do: [ :nodeArr | (nodeArr at: #trans) do: [ :transBlock | transBlock value: (nodeArr at: #node) name value: p ] ].
			1 halt ]