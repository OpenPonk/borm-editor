accessing
figuresFactory
	^ figuresFactory ifNil: [ figuresFactory := BormFiguresFactory new ]