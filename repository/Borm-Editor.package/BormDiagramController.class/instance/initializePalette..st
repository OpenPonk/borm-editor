initialization
initializePalette: aPalette
	aPalette
		newCreationTool: 'Participant' factory: [ BormParticipantController new ];
		newCreationTool: 'State' factory: [ BormStateController new ]