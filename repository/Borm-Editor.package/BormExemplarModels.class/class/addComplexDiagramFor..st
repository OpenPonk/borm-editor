adding
addComplexDiagramFor: aParticipant
	"initial -(a1)> mid -(a2)> final"

	| init a1 mid a2 fin |
	aParticipant
		add:
			(init := BormState new
				name: 'initial';
				isInitial: true).
	aParticipant add: (a1 := BormActivity new name: 'a1').
	aParticipant add: (mid := BormState new name: 'mid').
	aParticipant add: (a2 := BormActivity new name: 'a2').
	aParticipant
		add:
			(fin := BormState new
				name: 'final';
				isFinal: true).
	self bormEdgeFrom: init to: a1 with: BormTransition.
	self bormEdgeFrom: a1 to: mid with: BormTransition.
	self bormEdgeFrom: mid to: a2 with: BormTransition.
	self bormEdgeFrom: a2 to: fin with: BormTransition.
	^ aParticipant