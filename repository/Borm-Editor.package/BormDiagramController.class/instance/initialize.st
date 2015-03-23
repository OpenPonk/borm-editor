initialization
initialize
	super initialize.
	modelToControllerMapping
		at: BormCommunication put: BormCommunicationController;
		at: BormDataFlow put: BormDataFlowController;
		at: BormParticipant put: BormParticipantController;
		at: BormActivity put: BormActivityController;
		at: BormState put: BormStateController;
		at: BormTransition put: BormTransitionController