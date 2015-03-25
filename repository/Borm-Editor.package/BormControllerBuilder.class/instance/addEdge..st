private - building
addEdge: anEdge
	| sourceCtrl targetCtrl edgeCtrl |
	sourceCtrl := self controllerFor: anEdge source.
	targetCtrl := self controllerFor: anEdge target.
	edgeCtrl := self newControllerFor: anEdge.
	sourceCtrl addAsSourceFor: edgeCtrl.
	targetCtrl addAsTargetFor: edgeCtrl