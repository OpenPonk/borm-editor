accessing
quotedString
	^ ($" asParser , string , $" asParser) ==> [ :arr | arr second ]