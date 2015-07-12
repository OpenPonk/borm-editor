menu
menuCommandOn: aBuilder
	<worldMenu>
	((aBuilder item: #BORMEditor) icon: BormEditorIcons current diagram16Icon)
		label: 'BORM Editor';
		parent: #MostUsedTools;
		action: [ 
					"		withSeparatorAfter;"
					self openEmpty ];
		with: [ 
					(aBuilder item: #BORMExamples)
						parent: #BORMEditor;
						label: 'BORM Example';
						icon: BormEditorIcons current diagram16Icon;
						action: [ self examplePizzaDelivery ].

					(aBuilder item: #BORMExamples)
						parent: #BORMEditor;
						label: 'BORM Simple';
						icon: BormEditorIcons current diagram16Icon;
						action: [ self openTwoParticipants ] ]