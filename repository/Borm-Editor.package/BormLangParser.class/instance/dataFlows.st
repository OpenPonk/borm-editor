accessing
dataFlows
	^ (dataFlow separatedBy: #space asParser) withoutSeparators optional ==> [ :arr | arr ifNil: [ #() ] ]