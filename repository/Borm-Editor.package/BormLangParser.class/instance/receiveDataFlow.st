accessing
receiveDataFlow
	^ 'receive' asParser , space , quotedString , space , 'from' asParser , space , quotedString