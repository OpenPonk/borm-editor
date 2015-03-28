private - processing
processBlock: anArray
	participant := self processSpecification: anArray.
	nodes := Dictionary new.
	participantNodes at: anArray first ifPresent: [ :n | nodes := n ].
	anArray third do: [ :line | self processLine: line ].
	nodes values do: [ :each | participant add: each ].
	participantNodes at: anArray first put: nodes.
	diagram add: participant.
	^ participant