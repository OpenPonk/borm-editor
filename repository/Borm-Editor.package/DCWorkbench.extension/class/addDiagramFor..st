*Borm-Editor
addDiagramFor: aParticipant
	"initial -(a1)> mid -(a2)> final"

	aParticipant
		add:
			(BormState new
				name: 'initial';
				isInitial: true).
	aParticipant add: (BormActivity new name: 'an activity').
	aParticipant add: (BormState new name: 'mid').
	aParticipant add: (BormActivity new name: 'an activity2').
	aParticipant
		add:
			(BormState new
				name: 'final';
				isFinal: true).
	self transitionFrom: aParticipant nodes first to: aParticipant nodes second.
	self transitionFrom: aParticipant nodes second to: aParticipant nodes third.
	self transitionFrom: aParticipant nodes third to: aParticipant nodes fourth.
	self transitionFrom: aParticipant nodes fourth to: aParticipant nodes fifth.
	^ aParticipant