accessing
constraint
	^ super constraint ==> [ :condition | condition ifNotNil: [ BormConstraint named: condition ] ]