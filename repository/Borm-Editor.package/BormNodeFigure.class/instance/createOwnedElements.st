as yet unclassified
createOwnedElements
	| block |
	text := self figuresFactory newText
		text: [ :m | m model name ];
		wrapText;
		elementOn: self.
	self add: text.
	(RTConstraint on: text background: self) stick.
	block := [ :aShape :step | 
	text shape width: aShape width - 20.
	text update ].
	self addCallback: (TRTranslationCallback block: block).
	self addCallback: (TRExtentCallback block: block).
	plusIcon := RTBitmap new
		form: Smalltalk ui icons smallAddIcon;
		element.
	(RTConstraint on: plusIcon background: self)
		right;
		bottom;
		padding: 5;
		stick