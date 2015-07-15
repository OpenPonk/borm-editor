converting
constraint: aConstraint
	^ aConstraint ifNil: [ '' ] ifNotNil: [ ' if ' , aConstraint name ]