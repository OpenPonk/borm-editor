accessing
participant
	^ (participantType , space , nameExpression , space , ${ asParser , $} asParser)
		==> [ :arr | Array with: arr first with: arr third ]