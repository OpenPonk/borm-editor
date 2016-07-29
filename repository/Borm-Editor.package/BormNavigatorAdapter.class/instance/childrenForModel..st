widget API
childrenForModel: aModel
	"Always recreationg the BormNavigator* nodes will close the tree on change, so we need to cache it."
	^ modelChildren
		ifNil: [ modelChildren := Array
				with: (BormNavigatorElements new model: aModel)
				with: (BormNavigatorEntities new model: aModel) ]