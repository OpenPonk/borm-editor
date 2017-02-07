hooks
createEdgeFrom: fromElement to: toElement
	| edge shape |
	^ OPRTCallbackBuilder
		block: [ :view | 
			shape := OPRTStyledConnection new
				withBorderAttachPoint;
				color: Color black;
				width: 2.
			(self model target isKindOf: BormState)
				ifTrue: [ shape decorations filledNarrowArrowHead ].
			edge := shape edgeFrom: fromElement to: toElement.
			edge @ OPRTConnectionHandles.
			(self diagramController controllerForModel: self model source owner) figure trachelShape
				addCallback: (TRTranslationCallback block: [ :sh :step | shape translateBy: step for: edge ]).
			view add: edge.
			edge ]