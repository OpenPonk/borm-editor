widget API
childrenMapping
	^ {(BormORModel -> #participants).
	(BormParticipant -> #nodes).
	(BormState -> #outgoing).
	(BormActivity -> [ :o | o outgoing , o sent ]).
	(BormCommunication
		-> [ :o | o dataFlows , o constraint ifNil: [ #() ] ifNotNil: [ {o constraint} ] ]).
	(BormTransition -> [ :o | o constraint ifNil: [ #() ] ifNotNil: [ {o constraint} ] ])}