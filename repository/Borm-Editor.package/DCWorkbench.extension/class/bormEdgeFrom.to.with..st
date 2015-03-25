*Borm-Editor
bormEdgeFrom: aSourceNode to: aTargetNode with: aClass
	| aTransition |
	(aTransition := aClass new) from: aSourceNode to: aTargetNode.
	aSourceNode addTransition: aTransition.
	aTargetNode addTransition: aTransition.
	^ aTransition