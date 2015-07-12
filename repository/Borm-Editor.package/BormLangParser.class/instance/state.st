accessing
state
	^ ((stateType , space) optional ==> [ :arr | arr ifNotNil: [ arr first ] ] , 'state' asParser , space , nameExpression)
		==> [ :arr | { arr second . arr first . arr last } ]