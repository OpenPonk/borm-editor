private - building
addNodes: nodes
	nodes do: [ :node | (self controllerFor: node owner) addAsTargetFor: (self newControllerFor: node) ]