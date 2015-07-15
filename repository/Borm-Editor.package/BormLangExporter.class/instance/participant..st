converting
participant: aParticipant
	^ (self participantType: aParticipant type) , ' ' , (self name: aParticipant name) , ' ' , '{' , self newLine
		, (self nodes: aParticipant nodes) , self newLine , '}'