accessing
activity
	^ super activity ==> [ :arr | BormActivity named: arr second key ]