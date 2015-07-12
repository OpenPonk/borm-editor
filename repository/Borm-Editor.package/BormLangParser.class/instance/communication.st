accessing
communication
	^ ('send ' asParser , quotedString , ' to ' asParser , quotedString , (' and receive ' asParser , quotedString) optional)
		==> [ :arr | 
			{(arr fourth).
			(arr second).
			(arr fifth ifNotNil: [ arr fifth second ])} ]