hooks
connectionFeedback
	^ DCInteractiveLine new
		lineBuilder:
				[ :fromFigure :toFigure | 
			DCRTStyledConnection new
				arrowHead;
				withContinuousRectangleAttachPoint;
				color: Color darkGray muchDarker;
				edgeFrom: fromFigure to: toFigure ];
		from: source figure