accessing
participantType
	^ super participantType ==> [ :str | BormParticipantType perform: str asSymbol ]