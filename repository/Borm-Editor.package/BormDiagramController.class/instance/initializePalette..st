initialization
initializePalette: aPalette
	(aPalette newCreationTool: [ BormParticipantController new ])
		label: 'Participant';
		icon: BormEditorIcons current participant16Icon;
		shortcut: $q asShortcut.
	aPalette newSeparator.
	(aPalette newCreationTool: [ BormStateController new ])
		label: 'State';
		icon: BormEditorIcons current state16Icon;
		shortcut: $s asShortcut.
	(aPalette newCreationTool: [ BormActivityController new ])
		label: 'Activity';
		icon: BormEditorIcons current activity16Icon;
		shortcut: $a asShortcut.
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ BormTransitionController new ])
		label: 'Transition';
		icon: BormEditorIcons current transition16Icon;
		shortcut: $t asShortcut.
	(aPalette newConnectionCreationTool: [ BormCommunicationController new ])
		label: 'Communication';
		icon: BormEditorIcons current communication16Icon;
		shortcut: $c asShortcut.
	aPalette newSeparator.
	(aPalette newCreationTool: [ BormDataFlowController new ])
		label: 'Data Flow';
		icon: BormEditorIcons current dataFlow16Icon;
		shortcut: $f asShortcut.
	(aPalette newCreationTool: [ BormConstraintController new ])
		label: 'Constraint';
		icon: BormEditorIcons current constraint16Icon;
		shortcut: $r asShortcut