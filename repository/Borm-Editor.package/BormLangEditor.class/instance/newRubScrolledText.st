instance creation
newRubScrolledText
	^ RubScrolledTextMorph new
				vResizing: #spaceFill; 
      			hResizing: #spaceFill;
				beWrapped;
				autoAccept: true;
				updateTextWith: self newStartText;
				withLineNumbers;
				withTextSegmentIcons;
				asSpecAdapter.