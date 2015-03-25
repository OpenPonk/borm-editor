private - factories
newControllerFor: anObject
	^ (diagramController controllerNameFor: anObject) new
		model: anObject;
		yourself