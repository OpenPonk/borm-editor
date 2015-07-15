converting
communications: aCollection
	^ (aCollection collect: [ :each | self tab , self tab , (self communication: each) ]) joinUsing: self newLine