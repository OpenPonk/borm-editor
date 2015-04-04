hooks
refreshFigure
	self model isInitial & playBox view isNil
		ifTrue: [ figure view add: playBox ].
	self model isFinal & innerBox view isNil
		ifTrue: [ figure view add: innerBox ].
	self model isInitial not & playBox view isNotNil
		ifTrue: [ playBox remove ].
	self model isFinal not & innerBox view isNotNil
		ifTrue: [ innerBox remove ].
	super refreshFigure