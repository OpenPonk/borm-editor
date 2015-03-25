as yet unclassified
createModel
	| transition |
	transition := super createModel.
	source model addTransition: transition.
	target model addTransition: transition.
	^ transition