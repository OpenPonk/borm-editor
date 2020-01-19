menu
menuCommandOn: aBuilder
	<worldMenu>
	((aBuilder item: #BORMEditor)
		icon: BormEditorIcons current oRModel16Icon)
		label: 'BORM Editor';
		order: 25.725;
		parent: #MostUsedTools;
		action: [ self exampleEmpty ];
		with: [ (aBuilder item: #BORMExamples)
				parent: #BORMEditor;
				label: 'BORM Example Pizza Delivery';
				icon: BormEditorIcons current oRModel16Icon;
				action: [ self examplePizzaDelivery ].
			(aBuilder item: #BORMExamples)
				parent: #BORMEditor;
				label: 'BORM Simple Diagram';
				icon: BormEditorIcons current oRModel16Icon;
				action: [ self exampleDataFlows ] ]