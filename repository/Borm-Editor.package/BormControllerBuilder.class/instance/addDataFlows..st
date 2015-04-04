private - building
addDataFlows: dataFlows
	dataFlows do: [ :each | (self controllerFor: each owner) addAsTargetFor: (self newControllerFor: each) ]