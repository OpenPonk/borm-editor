private - processing
processEdge: anArray
	| source target edge cls |
	source := self processSpecification: (Array with: anArray first with: #()).
	target := self processSpecification: (Array with: anArray third with: #()).
	anArray second = '->'
		ifTrue: [ cls := BormTransition ].
	anArray second = '->>'
		ifTrue: [ cls := BormCommunication ].
	edge := cls from: source to: target.
	source addTransition: edge.
	target addTransition: edge.
	^ edge