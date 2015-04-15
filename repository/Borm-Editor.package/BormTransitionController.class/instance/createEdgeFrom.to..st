hooks
createEdgeFrom: fromElement to: toElement
	| edge shape |
	^ DCRTCallbackBuilder
		block: [ :view | 
			shape := DCRTNewMultiLine new
				withContinuousRectangleAttachPoint;
				color: Color black;
				width: 2.
			(self model target isKindOf: BormState)
				ifTrue: [ shape filledNarrowArrowHead ].
			edge := shape edgeFrom: fromElement to: toElement.
			edge @ DCRTLineHandles.
			(self diagramController controllerForModel: self model source owner) figure trachelShape
				addCallback: (TRTranslationCallback block: [ :sh :step | shape translateBy: step for: edge ]).
			view add: edge.
			edge ]