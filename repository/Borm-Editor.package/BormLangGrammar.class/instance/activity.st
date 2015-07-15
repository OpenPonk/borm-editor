accessing
activity
	^ ('activity' asParser , space , namePair) ==> [ :arr | arr last ]