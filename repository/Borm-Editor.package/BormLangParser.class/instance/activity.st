accessing
activity
	^ ('activity' asParser , space , nameExpression) ==> [ :arr | { arr first . arr last } ]