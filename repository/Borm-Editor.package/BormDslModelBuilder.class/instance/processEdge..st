private - processing
processEdge: anArray
	| source target edge |
	source := self processSpecification: (Array with: anArray first with: #()).
	target := self processSpecification: (Array with: anArray third with: #()).
	anArray second = '->'
		ifTrue: [ 
			edge := BormTransition from: source to: target.
			source addTransition: edge.
			target addTransition: edge ].
	anArray second = '->>'
		ifTrue: [ 
			edge := BormCommunication from: source to: target.
			source send: edge.
			target receive: edge ].
	^ edge