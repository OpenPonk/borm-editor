userinterface
rebuild
	| builder bb |
	controllers := nil.
	self view cleanAll.
	builder := BormControllerBuilder new.
	builder
		diagramController: self;
		view: self view;
		diagram: self model;
		build.
	bb := BormBasicLayout new.
	bb diagramController: self.
	bb applyLayout