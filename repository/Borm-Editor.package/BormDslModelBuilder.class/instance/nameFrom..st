private - utility
nameFrom: anArray
	^ anArray second isEmpty
		ifTrue: [ anArray first ]
		ifFalse: [ anArray second first ]