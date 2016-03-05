hooks
connectionFeedback
	^ DCInteractiveLine new
		lineBuilder: [ :fromFigure :toFigure | 
			DCRTStyledConnection new
				decorate: [ :deco | deco arrowHead ];
				withContinuousRectangleAttachPoint;
				color: Color darkGray muchDarker;
				edgeFrom: fromFigure to: toFigure ];
		from: source figure