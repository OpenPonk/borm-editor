accessing
transition
	^ 'go to ' asParser , name , constraint
		map: [ :goTo :pair :condition | 
			{pair. condition} ]