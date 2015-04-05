layouting
layoutDiagram: aDiagram
	aDiagram participants do: [ :each | self layoutParticipant: each ].
	self layoutParticipants: aDiagram participants.
	self updateView.
	self layoutCommunications: (self collectCommunications: aDiagram participants).
	self updateView