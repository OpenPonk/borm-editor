toolbar
toolbarMenu: aBuilder
	<dcEditorToolbarMenu: #BormDCPlugin>
	(aBuilder item: 'DSL Editor')
		action: [ DCDslEditor new
				parser: BormLangParser new;
				exporter: BormLangSerializer new;
				highlighter: BormLangHighlighter new;
				modelClass: BormORModel;
				model: aBuilder model diagramController model;
				openWithSpec ]