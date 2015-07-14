accessing
communication
	^ (('talk to ' asParser , name) ==> [ :arr | { arr second . nil . nil } ])
		/ (('send ' asParser , name , ' to ' asParser , name , (' and receive ' asParser , name) optional) ==> [ :arr | { arr fourth . arr second . arr fifth ifNotNil: [ arr fifth second ] } ])