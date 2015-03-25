accessing
createModel
	| communication |
	communication := super createModel.
	source model send: communication.
	target model receive: communication.
	^ communication