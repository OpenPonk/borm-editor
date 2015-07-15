menu
menuCommandOn: aBuilder
	<worldMenu>
	((aBuilder item: #BORMEditor) icon: BormEditorIcons current diagram16Icon)
		label: 'BORM Editor';
		parent: #MostUsedTools;
		action: [ 
					"		withSeparatorAfter;"
					self exampleEmpty ];
		with: [ 
					(aBuilder item: #BORMExamples)
						parent: #BORMEditor;
						label: 'BORM Example Pizza Delivery';
						icon: BormEditorIcons current diagram16Icon;
						action: [ self examplePizzaDelivery ].

					(aBuilder item: #BORMExamples)
						parent: #BORMEditor;
						label: 'BORM Simple Diagram';
						icon: BormEditorIcons current diagram16Icon;
						action: [ self exampleDataFlows ] ]