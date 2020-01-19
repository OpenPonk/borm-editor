toolbar
toolbarMenu: aBuilder
	<opEditorToolbarMenu: #BormPlugin>
	(aBuilder item: 'DSL Editor')
		action: [ OPDslEditor new
				parser: BormLangParser new;
				exporter: BormLangSerializer new;
				highlighter: BormLangHighlighter new;
				modelClass: BormORModel;
				model: aBuilder model diagramController model;
				openWithSpec ]