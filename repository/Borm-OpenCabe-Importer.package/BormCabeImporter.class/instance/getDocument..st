retrieving
getDocument: aPath
	^ self parseXml: (root resolve: aPath)