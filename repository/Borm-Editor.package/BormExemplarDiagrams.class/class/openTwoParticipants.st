as yet unclassified
openTwoParticipants
	<example>
	| diagram project user system |
	project := DCProject new projectName: 'Example BORM'.
	diagram := BormDiagram new name: 'BORM diagram'.
	project addDiagram: diagram.	
	user := BormParticipant new name: 'User'.
	system := BormParticipant new name: 'System'.
	system type: BormParticipantType System.
	diagram add: user; add: system.
	self addDiagramFor: user.
	self addDiagramFor: system.
	self addCommunicationsBetween: user and: system.
	DCWorkbench openProject: project