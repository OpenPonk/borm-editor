widget API
displayMapping
	^ {BormNavigatorNode -> [ :o | (o className splitOn: 'BormNavigator') last  ].
	OPModelObject -> [ :o | self bormNameFor: o ]}