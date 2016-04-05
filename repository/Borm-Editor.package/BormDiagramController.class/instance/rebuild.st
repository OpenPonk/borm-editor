userinterface
rebuild
	| builder |
	self controllers do: #remove.
	controllers := nil.
	builder := BormControllerBuilder new.
	builder
		diagramController: self;
		view: self view;
		diagram: self model;
		build