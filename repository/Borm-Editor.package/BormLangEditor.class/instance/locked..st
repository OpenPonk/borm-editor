locking
locked: aBlock
	locked
		ifTrue: [ ^ self ].
	self lock.
	aBlock value.
	self unlock