accessing
namePair
	^ (name , ((space , 'as' asParser , space , name) ==> [ :arr | arr fourth ]) optional)
		==> [ :arr | arr first -> (arr second ifNil: [ arr first ]) ]