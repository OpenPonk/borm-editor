Extension { #name : #BormORModel }

{ #category : #'*Borm-Editor' }
BormORModel >> open [
	self openAs: 'New BORM Project'
]

{ #category : #'*Borm-Editor' }
BormORModel >> openAs: aProjectName [
	OPProject new
		name: aProjectName;
		addModel: self;
		open
]
