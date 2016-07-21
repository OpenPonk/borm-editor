as yet unclassified
state
	^ ((stateType , space) optional , 'state' asParser token , space token , namePair)
		==> [ :n | 
			{n first.
			n second -> Color purple.
			n last} ]