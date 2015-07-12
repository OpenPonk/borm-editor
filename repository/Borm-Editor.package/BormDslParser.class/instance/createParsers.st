private
createParsers
	| quotedParam param anyParam optionalParams params innerBlock part dataFlows flowParam optionalFlowParams |
	part := #word asParser star ==> [ :str | String newFrom: str ].
	id := ((part , $. asParser) flatten optional , part)
		==> [ :arr | (arr first ifNil: [ '' ] ifNotNil: [ arr first ]) , arr second ].

	quotedParam := ($' asParser , $' asParser negate star , $' asParser) ==> [ :str | String newFrom: str second ].
	param := #word asParser plus ==> [ :str | String newFrom: str ].
	anyParam := param / quotedParam.
	optionalParams := ((', ' asParser , anyParam) ==> [ :str | str second ]) star.
	params := ($( asParser , anyParam , optionalParams , $) asParser) ==> [ :arr | (Array with: arr second) , arr third ].

	specification := id , params.

	flowParam := params.
	optionalFlowParams := ((', ' asParser , flowParam) ==> [ :arr | arr second ]) star.
	dataFlows := ($[ asParser , flowParam , optionalFlowParams , $] asParser)
		==> [ :arr | (Array with: arr second) , arr third ].

	transition := id , (' -> ' asParser ==> [ :str | str trim ]) , id.
	communication := id , (' ->> ' asParser ==> [ :str | str trim ]) , id
		, (((Character space asParser , dataFlows) ==> [ :arr | arr second ]) optional ==> [ :arr | arr ifNil: [ #() ] ]).

	edge := transition / communication.

	line := (#tab asParser optional, (edge / specification)) ==> [:arr | arr second ].
	innerBlock := ((line , Character cr asParser) ==> [ :arr | arr first ]) star.

	block := (specification , ${ asParser , Character cr asParser , innerBlock , $} asParser
		, Character cr asParser optional) ==> [ :arr | Array with: arr first with: arr second with: arr fifth ].

	diagram := block star