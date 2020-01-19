toolbar
canvasToolbarFor: aBuilder
	<opCanvasToolbar: #BormPlugin>
	(aBuilder item: 'Layout')
		action: [ aBuilder model diagramController applyDefaultLayout ]