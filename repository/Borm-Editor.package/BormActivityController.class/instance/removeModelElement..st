as yet unclassified
removeModelElement: aTransitionOrCommunication
	(aTransitionOrCommunication isKindOf: BormTransition)
		ifTrue: [ ^ super removeModelElement: aTransitionOrCommunication ].
	self model removeCommunication: aTransitionOrCommunication.
	aTransitionOrCommunication receiver removeCommunication: aTransitionOrCommunication