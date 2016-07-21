toolbar
canvasToolbarFor: aBuilder
	<dcCanvasToolbar: #BormDCPlugin>
	(aBuilder item: 'Layout') action: [ aBuilder model diagramController applyDefaultLayout ]