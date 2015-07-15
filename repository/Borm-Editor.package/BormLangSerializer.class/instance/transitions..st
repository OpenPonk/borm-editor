converting
transitions: aCollection
	^ (aCollection collect: [ :each | self tab , self tab , (self transition: each) ]) joinUsing: self newLine