converting
nodes: aCollection
	^ (aCollection collect: [ :each | self tab , (self node: each) ]) joinUsing: self newLine , self newLine