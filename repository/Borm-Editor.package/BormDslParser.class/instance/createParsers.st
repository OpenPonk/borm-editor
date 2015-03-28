private
createParsers
	| quotedParam param anyParam optionalParams params id |
	id := #word asParser plus ==> [ :str | String newFrom: str ].

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
	block := (line , ((Character cr asParser , line) ==> [ :arr | arr second ]) star , Character lf asParser star)
		==> [ :arr | (Array with: arr first) , arr second ]