as yet unclassified
rebuild
	| builder |
	controllers := nil.
	self view cleanAll.
	builder := BormControllerBuilder new.
	builder
		diagramController: self;
		view: self view;
		diagram: self model;
		build