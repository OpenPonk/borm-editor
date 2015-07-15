converting
communication: aCommunication
	| to flows |
	to := aCommunication receiver.
	flows := aCommunication dataFlows.

	^ flows isEmpty
		ifTrue: [ 'talk to ' , to name ]
		ifFalse: [ 
			'send ' , (self name: flows first name) , ' to ' , (self name: to owner name, '::', to name)
				,
					(flows size > 1
						ifTrue: [ ' and receive ' , (self name: flows second name) ]
						ifFalse: [ '' ]) ]