accessing
transition
	^ ('go to ' asParser , quotedString , (' if ' asParser , quotedString) optional)
		==> [ :arr | 
			{(arr second).
			(arr third ifNotNil: [ arr third second ])} ]