accessing
activity
	^ super activity ==> [ :pair | nodesLookup at: pair value put: (BormActivity named: pair key) ]