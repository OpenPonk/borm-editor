as yet unclassified
layoutCommunications: communications
	communications
		do: [ :c | 
			| figures |
			figures := c dataFlows collect: [ :each | (diagramController controllerForModel: each) figure ].
			RTVerticalLineLayout new
				gapSize: 50;
				on: figures ]