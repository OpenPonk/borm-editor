accessing
participant
	^ (participantType , space , namePair , space , ${ asParser , #newline asParser , nodes
		, #newline asParser optional , $} asParser) map: [ :type :sp :pair :sp2 :bra :nl :vertices :nl2 :ket
 | { type . pair . vertices }
			  ]
