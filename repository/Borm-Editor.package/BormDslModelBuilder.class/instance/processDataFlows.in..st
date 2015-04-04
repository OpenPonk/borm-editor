private - processing
processDataFlows: anArray in: aCommunication
	anArray
		do: [ :params | 
			| flow |
			flow := BormDataFlow new.
			flow name: params first.
			(params includes: 'input')
				ifTrue: [ flow beInput ].
			(params includes: 'output')
				ifTrue: [ flow beOutput ].
			aCommunication addDataFlow: flow ]