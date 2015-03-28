instance creation
openProject: aProjectName diagram: aDiagramName dsl: dslSpec
	DCWorkbench
		openProject:
			(DCProject new
				projectName: aProjectName;
				addDiagram:
						((BormDslModelBuilder new parse: dslSpec)
								name: aDiagramName;
								yourself);
				yourself)