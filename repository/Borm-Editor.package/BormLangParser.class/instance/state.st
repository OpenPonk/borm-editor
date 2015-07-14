accessing
state
	^ (stateType , space) optional , 'state' asParser , space , namePair
		map: [ :type :smb :sp :pair | 
			{(type ifNotNil: [ type first ]).
			pair} ]