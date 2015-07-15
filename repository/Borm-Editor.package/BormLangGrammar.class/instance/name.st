accessing
name
	^ ($" asParser , string , $" asParser) ==> [ :arr | arr second ]