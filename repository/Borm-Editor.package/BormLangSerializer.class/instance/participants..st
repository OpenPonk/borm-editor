converting
participants: aCollection
	^ (aCollection collect: [ :each | self participant: each ])
		joinUsing: self newLine , self newLine