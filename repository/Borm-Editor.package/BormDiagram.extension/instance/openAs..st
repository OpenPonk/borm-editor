*Borm-Editor
openAs: aProjectName
	DCWorkbench
		openProject:
			(DCProject new
				projectName: aProjectName;
				addDiagram: self;
				yourself)