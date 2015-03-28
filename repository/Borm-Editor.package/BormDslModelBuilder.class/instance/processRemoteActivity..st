private - processing
processRemoteActivity: anArray
	| name aParticipant params activity |
	name := anArray first splitOn: '.'.
	aParticipant := participants at: name first.
	(participantNodes at: name first) at: name second ifPresent: [ :item | ^ item ].
	params := anArray second.
	activity := BormActivity new.
	activity name: (self nameFrom: (Array with: name second with: #())).
	(participantNodes at: name first) at: name second put: activity.
	^ activity