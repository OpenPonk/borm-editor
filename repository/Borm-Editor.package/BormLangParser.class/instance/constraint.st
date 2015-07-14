accessing
constraint
	^ (space , 'if' asParser , space , name) optional ==> [ :arr | arr ifNotNil: [ arr fourth ] ]