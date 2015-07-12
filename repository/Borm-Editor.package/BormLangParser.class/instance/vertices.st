accessing
vertices
	^ (vertex separatedBy: newLine) withoutSeparators optional ==> [ :arr | arr ifNil: [ #() ] ]