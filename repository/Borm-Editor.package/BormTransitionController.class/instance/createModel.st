as yet unclassified
createModel
	| transition |
	self model ifNotNil: [ ^ self model ].
	transition := super createModel.
	source model addTransition: transition.
	target model addTransition: transition.
	^ transition