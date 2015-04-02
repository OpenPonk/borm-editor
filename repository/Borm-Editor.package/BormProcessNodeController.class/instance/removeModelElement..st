removing
removeModelElement: aTransition
	self model removeTransition: aTransition.
	aTransition target removeTransition: aTransition