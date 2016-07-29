widget API
displayMapping
	^ {BormNavigatorNode -> [ :o | (o className splitOn: 'BormNavigator') last  ].
	DCModelObject -> [ :o | self bormNameFor: o ]}