converting
constraint: aConstraint
	^ aConstraint ifNil: [ '' ] ifNotNil: [ ' if ' , (self name: aConstraint name) ]