as yet unclassified
createOwnedElements
	| block |
	super createOwnedElements.
	playIcon := RTBitmap new
		form: BormEditorIcons current initialIcon;
		element.
	(RTConstraint on: playIcon background: self)
		right;
		padding: 5;
		stick.
	innerBox := self figuresFactory newBox
		color: Color transparent;
		element.
	block := [ :aShape :step | 
	innerBox
		width: self width - 10;
		height: self height - 10.
	innerBox translateTo: self position ].
	self addCallback: (TRTranslationCallback block: block).
	self addCallback: (TRExtentCallback block: block)