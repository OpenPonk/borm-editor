layouting
layoutParticipants: participants
	| figures |
	figures := participants collect: [ :each | (diagramController controllerForModel: each) figure ].
	RTHorizontalLineLayout new gapSize: 50; on: figures