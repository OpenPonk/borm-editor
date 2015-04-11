initialization
initializePalette: aPalette
	aPalette
		newCreationTool: 'Participant'
			factory: [ BormParticipantController new ]
			icon: BormEditorIcons current participant16Icon;
		newSeparator;
		newCreationTool: 'State' factory: [ BormStateController new ] icon: BormEditorIcons current state16Icon;
		newCreationTool: 'Activity' factory: [ BormActivityController new ] icon: BormEditorIcons current activity16Icon;
		newSeparator;
		newConnectionCreationTool: 'Transition'
			factory: [ BormTransitionController new ]
			icon: BormEditorIcons current transition16Icon;
		newConnectionCreationTool: 'Communication'
			factory: [ BormCommunicationController new ]
			icon: BormEditorIcons current communication16Icon;
		newSeparator;
		newCreationTool: 'Data Flow' factory: [ BormDataFlowController new ] icon: BormEditorIcons current dataFlow16Icon;
		newCreationTool: 'Constraint'
			factory: [ BormConstraintController new ]
			icon: BormEditorIcons current constraint16Icon