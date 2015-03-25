accessing
createModel
	| communication |
	self model ifNotNil: [ ^ self model ].
	communication := super createModel.
	source model send: communication.
	target model receive: communication.
	^ communication