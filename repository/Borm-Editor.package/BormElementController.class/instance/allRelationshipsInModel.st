rebuilding
allRelationshipsInModel
	^ self allOwnedElementsInModel
		flatCollect:
			[ :each | (diagramController controllerForModel: each) allRelationshipsInModel ]