accessing
participants
	^ (participant separatedBy: #space asParser) withoutSeparators optional ==> [ :arr | arr ifNil: [ #() ] ]