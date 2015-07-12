accessing
nameExpression
	^ (quotedString , ((space , 'as' asParser , space , quotedString) ==> [ :arr | arr fourth ]) optional)
		==> [ :arr | arr first -> arr second ]