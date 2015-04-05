initialization
initializePalette: aPalette
	aPalette
		newCreationTool: 'Participant' factory: [ BormParticipantController new ];
		newSeparator;
		newCreationTool: 'State' factory: [ BormStateController new ];
		newCreationTool: 'Activity' factory: [ BormActivityController new ];
		newSeparator;
		newConnectionCreationTool: 'Transition' factory: [ BormTransitionController new ];
		newConnectionCreationTool: 'Communication' factory: [ BormCommunicationController new ];
		newSeparator;
		newCreationTool: 'Data Flow' factory: [ BormDataFlowController new ]