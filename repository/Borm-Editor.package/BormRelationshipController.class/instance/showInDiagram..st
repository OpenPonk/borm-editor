construction
showInDiagram: aDiagramController
	aDiagramController
		controllerForModel: model target
		ifNone: [ ^ aDiagramController
				controllerForModel: model source
				ifNone: [ self
						error:
							'Trying to create controller for relationship that depends on elements, but none of them is shown in diagram before' ] ].
	aDiagramController
		controllerForModel: model source
		ifNone: [ ^ self ].
	^ super showInDiagram: aDiagramController