as yet unclassified
openComplexParticipant
	<example>
	| diagram project user |
	project := DCProject new projectName: 'Example BORM'.
	diagram := BormDiagram new name: 'BORM diagram'.
	project addDiagram: diagram.
	user := BormParticipant new name: 'User'.
	diagram add: user.
	self addComplexDiagramFor: user.
	DCWorkbench openProject: project