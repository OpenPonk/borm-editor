private - processing
processParticipant: anArray
	| params |
	params := anArray second.
	participant := BormParticipant new.
	participant name:  (self nameFrom: anArray).
	params size >= 2
		ifTrue: [ participant type: (BormParticipantType perform: params second capitalized asSymbol) ].
	params size >= 3
		ifTrue: [ participant role: (BormParticipantRole perform: params third capitalized asSymbol) ].
	^ participant