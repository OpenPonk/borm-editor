widget API
childrenForModel: aModel
	^ Array
		with: (BormNavigatorElements new model: aModel)
		with: (BormNavigatorEntities new model: aModel)