userinterface
applyDefaultLayout
	self halt.
	BormBasicLayout new
		diagramController: self;
		applyLayout