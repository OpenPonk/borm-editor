private
createParsers
	| quotedParam param anyParam optionalParams params innerBlock part |
	part := #word asParser star ==> [ :str | String newFrom: str ].
	id := ((part , $. asParser) flatten optional , part)
		==> [ :arr | (arr first ifNil: [ '' ] ifNotNil: [ arr first ]) , arr second ].

	transition := id , (' -> ' asParser ==> [ :str | str trim ]) , id.
	communication := id , (' ->> ' asParser ==> [ :str | str trim ]) , id.
	edge := transition / communication.

	quotedParam := ($' asParser , $' asParser negate star , $' asParser) ==> [ :str | String newFrom: str second ].
	param := #word asParser plus ==> [ :str | String newFrom: str ].
	anyParam := param / quotedParam.
	optionalParams := ((', ' asParser , anyParam) ==> [ :str | str second ]) star.
	params := ($( asParser , anyParam , optionalParams , $) asParser) ==> [ :arr | (Array with: arr second) , arr third ].

	specification := id , params.

	line := edge / specification.
	innerBlock := ((line , Character cr asParser) ==> [ :arr | arr first ]) star.

	block := (specification , ${ asParser , Character cr asParser , innerBlock , $} asParser
		, Character cr asParser optional) ==> [ :arr | Array with: arr first with: arr second with: arr fifth ].

	diagram := block star