as yet unclassified
removeModelElement: aTransitionOrCommunication
	(aTransitionOrCommunication isKindOf: BormTransition)
		ifTrue: [ ^ super removeModelElement: aTransitionOrCommunication ].
	self model removeTransition: aTransitionOrCommunication.
	aTransitionOrCommunication target removeTransition: aTransitionOrCommunication