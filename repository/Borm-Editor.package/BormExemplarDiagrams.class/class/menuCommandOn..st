menu
menuCommandOn: aBuilder
	<worldMenu>
	((aBuilder item: #BORMEditor) icon: BormEditorIcons current diagram16Icon)
		label: 'BORM Editor';
		parent: #MostUsedTools;
"		withSeparatorAfter;"
		action: [ self openEmpty ];
		with: [ 
					(aBuilder item: #BORMExamples)
						parent: #BORMEditor;
						label: 'BORM Two Participants';
						icon: BormEditorIcons current diagram16Icon;
						action: [ self openTwoParticipants ].

					"(aBuilder item: #BORMExamples)
						parent: #BORMEditor;
						label: 'BORM With Data Flows';
						icon: BormEditorIcons current diagram16Icon;
						action: [ self openWithDataFlows ] "]