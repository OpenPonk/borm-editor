toolbar
toolbarMenu: aBuilder
	<opEditorToolbarMenu: #BormDCPlugin>
	(aBuilder item: 'DSL Editor')
		action: [ OPDslEditor new
				parser: BormLangParser new;
				exporter: BormLangSerializer new;
				highlighter: BormLangHighlighter new;
				modelClass: BormORModel;
				model: aBuilder model diagramController model;
				openWithSpec ]