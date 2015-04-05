as yet unclassified
layoutCommunications: communications
	communications
		do: [ :c | 
			| figures rect currentMid targetMid vector |
			figures := c dataFlows collect: [ :each | (diagramController controllerForModel: each) figure ].
			figures isNotEmpty
				ifTrue: [ 
					RTHorizontalLineLayout new
						gapSize: 10;
						on: figures.
					rect := Rectangle merging: (figures collect: [ :each | each encompassingRectangle ]).
					currentMid := rect center.
					targetMid := (diagramController controllerForModel: c) figure encompassingRectangle center.
					vector := targetMid - currentMid.
					figures do: [ :flow | flow translateBy: vector ].

					figures do: [ :flow | flow announce: TRMouseDragEnd new ] ] ]