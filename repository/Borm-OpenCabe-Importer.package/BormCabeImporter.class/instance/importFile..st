importing
importFile: aFileReference
	root := (FileSystem zip: aFileReference) open workingDirectory.
	self importProject: (self getDocument: 'project.xmi')