Extension { #name : 'BormORModel' }

{ #category : '*OpenPonk-BormEditor' }
BormORModel >> open [
	self openAs: 'New BORM Project'
]

{ #category : '*OpenPonk-BormEditor' }
BormORModel >> openAs: aProjectName [

	(OPProject new
		 name: aProjectName;
		 addModel: self;
		 open) showAllElementsInAllDiagrams
]
