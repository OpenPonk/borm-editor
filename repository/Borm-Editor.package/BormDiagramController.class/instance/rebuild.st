userinterface
rebuild
	| builder bb |
	self controllers do: #remove.
	controllers := nil.
	builder := BormControllerBuilder new.
	builder
		diagramController: self;
		view: self view;
		diagram: self model;
		build.
	bb := BormBasicLayout new.
	bb diagramController: self.
	bb applyLayout