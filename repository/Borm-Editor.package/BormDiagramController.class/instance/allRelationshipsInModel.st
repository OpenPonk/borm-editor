rebuilding
allRelationshipsInModel
	^ self allOwnedElementsInModel
		flatCollect: [ :each | 
			(self diagramController controllerForModel: each)
				allRelationshipsInModel ]