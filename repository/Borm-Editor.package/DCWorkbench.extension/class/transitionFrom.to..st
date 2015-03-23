*Borm-Editor
transitionFrom: aSourceNode to: aTargetNode
	| aTransition |
	(aTransition := BormTransition new) from: aSourceNode to: aTargetNode.
	aSourceNode addTransition: aTransition.
	aTargetNode addTransition: aTransition.
	^ aTransition