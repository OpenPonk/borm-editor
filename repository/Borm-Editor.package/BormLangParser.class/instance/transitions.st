accessing
transitions
	^ (transition separatedBy: #space asParser) withoutSeparators optional ==> [ :arr | arr ifNil: [ #() ] ]