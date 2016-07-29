widget API
childrenMapping
	^ {BormORModel -> [ :m | self childrenForModel: m ].
	BormEntity -> #representations.
	BormNavigatorNode -> #children.
	BormParticipant -> #nodes.
	BormState -> #outgoing.
	BormActivity -> [ :o | o outgoing , o sent ].
	BormCommunication
		-> [ :o | o dataFlows , (o constraint ifNil: [ #() ] ifNotNil: [ {o constraint} ]) ].
	BormTransition -> [ :o | o constraint ifNil: [ #() ] ifNotNil: [ {o constraint} ] ]}